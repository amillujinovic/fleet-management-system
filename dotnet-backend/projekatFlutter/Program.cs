using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using projekatFlutter.Data;
using projekatFlutter.Models;
using projekatFlutter.Repositories;
using projekatFlutter.Services;
using System.Text;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});
builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles;
    });
// Add services to the container
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        Scheme = "Bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "Zalijepi samo JWT token (bez 'Bearer ' prefiksa)."
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
});

// Database Context
builder.Services.AddDbContext<ApiDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddScoped(typeof(IRepository<,>), typeof(Repository<,>));
builder.Services.AddScoped<IRepository<ObdReading, long>, Repository<ObdReading, long>>();
builder.Services.AddScoped<IRepository<DriversNote, int>, Repository<DriversNote, int>>();
builder.Services.AddSingleton<JwtServices>();

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuerSigningKey = true,
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]!)
            ),
            ValidateIssuer = true,
            ValidIssuer = builder.Configuration["Jwt:Issuer"],
            ValidateAudience = true,
            ValidAudience = builder.Configuration["Jwt:Audience"],
            ValidateLifetime = true,
            ClockSkew = TimeSpan.Zero
        };
    });

builder.Services.AddAuthorization();
builder.Services.AddHttpClient();
var app = builder.Build();
app.UseCors("AllowAll");
// Seed Data
using (var scope = app.Services.CreateScope())
{
    var context = scope.ServiceProvider.GetRequiredService<ApiDbContext>();
    context.Database.EnsureCreated();

    if (context.Vehicles.Any())
    {
        Console.WriteLine(" Data already exists");
    }
    else
    {
        try
        {
            DbSeeder.SeedData(context);
            Console.WriteLine(" Data seeded successfully!");
        }
        catch (Exception ex)
        {
            Console.WriteLine($" Seeder error: {ex.Message}");
        }
    }
}

// Configure the HTTP request pipeline
app.UseSwagger();
app.UseSwaggerUI();

app.UseAuthorization();
app.MapControllers();

app.Run();