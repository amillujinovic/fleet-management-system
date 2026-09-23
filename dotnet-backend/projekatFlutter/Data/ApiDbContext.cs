namespace projekatFlutter.Data;
using Microsoft.EntityFrameworkCore;
using projekatFlutter.Models;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using System.Linq;
using Microsoft.EntityFrameworkCore;
public class ApiDbContext : DbContext
{
    public ApiDbContext(DbContextOptions<ApiDbContext> options) : base(options) { }

    public DbSet<User> Users { get; set; } //this will become my Users table in sql
    public DbSet<Vehicle> Vehicles { get; set; }
    public DbSet<Alert> Alerts { get; set; }
    public DbSet<DeviceTracker> DeviceTrackers { get; set; }
    public DbSet<FuelRecord> FuelRecords { get; set; }
    public DbSet<Geofence> Geofences { get; set; }
    public DbSet<MaintenanceRecord> MaintenanceRecords { get; set; }
    public DbSet<Trip> Trips { get; set; }
    public DbSet<TripWaypoint> TripWaypoints { get; set; }
    public DbSet<VehicleGeofence> VehicleGeofences { get; set; }
    public DbSet<VehicleLocation> VehicleLocations { get; set; }
    public DbSet<ObdReading> ObdReadings { get; set; }
    public DbSet<DriversNote> DriversNotes { get; set; }

    // Npgsql prima samo UTC za timestamptz, a frontend salje datume bez zone.
    // Svaki DateTime se prije upisa pretvara u UTC.
    protected override void ConfigureConventions(ModelConfigurationBuilder configurationBuilder)
    {
        configurationBuilder.Properties<DateTime>().HaveConversion<UtcDateTimeConverter>();
        configurationBuilder.Properties<DateTime?>().HaveConversion<UtcDateTimeConverter>();
    }

    private class UtcDateTimeConverter : ValueConverter<DateTime, DateTime>
    {
        public UtcDateTimeConverter() : base(
            v => v.Kind == DateTimeKind.Utc ? v
               : v.Kind == DateTimeKind.Local ? v.ToUniversalTime()
               : DateTime.SpecifyKind(v, DateTimeKind.Utc),
            v => DateTime.SpecifyKind(v, DateTimeKind.Utc))
        { }
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<VehicleGeofence>()
            .HasKey(vg => new { vg.VehicleId, vg.GeofenceId });

        modelBuilder.Entity<VehicleGeofence>()
            .HasOne(vg => vg.Vehicle)
            .WithMany(v => v.VehicleGeofences)
            .HasForeignKey(vg => vg.VehicleId)
            .OnDelete(DeleteBehavior.Cascade);

 
        modelBuilder.Entity<VehicleGeofence>()
            .HasOne(vg => vg.Geofence)
            .WithMany(g => g.VehicleGeofences)
            .HasForeignKey(vg => vg.GeofenceId)
            .OnDelete(DeleteBehavior.Restrict);


        foreach (var fk in modelBuilder.Model.GetEntityTypes()
            .SelectMany(t => t.GetForeignKeys())
            .Where(fk => fk.PrincipalEntityType.ClrType == typeof(Vehicle)))
        {
            fk.DeleteBehavior = DeleteBehavior.Cascade;
        }
    }
}