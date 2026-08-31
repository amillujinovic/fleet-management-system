using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using projekatFlutter.Data;
using projekatFlutter.Models;
using projekatFlutter.Services;

namespace projekatFlutter.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly ApiDbContext _context;
        private readonly JwtServices _jwtServices;
        public AuthController(ApiDbContext context,JwtServices services)
        {
            _context = context;
            _jwtServices = services;
        }
        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] User user)
        {
            // here i check if user exist
            if (await _context.Users.AnyAsync(u => u.Email == user.Email))
            {
                return BadRequest("User with this email allready exists.");
            }
            user.Id = Guid.NewGuid().ToString();
            _context.Users.Add(user);
            await _context.SaveChangesAsync();
            var token = _jwtServices.GenerateToken(user.Id, user.Email, user.Name);

            return Ok(new
            {
                message = "Registration successful!",
                token = token,
                user = new
                {
                    id = user.Id,
                    name = user.Name,
                    email = user.Email
                }
            });

            // 3. saving changes to base
            await _context.SaveChangesAsync();

            return Ok(new { message = "Registracija uspješna!" });
        }

        // Login route
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] User loginData)
        {
            // Searching user by mail and password
            var user = await _context.Users
                .FirstOrDefaultAsync(u => u.Email == loginData.Email && u.Password == loginData.Password);

            if (user == null)
            {
                return Unauthorized("Pogrešan email ili lozinka.");
            }
            var token = _jwtServices.GenerateToken(user.Id, user.Email, user.Name);

            return Ok(new
            {
                token = token,
                user = new
                {
                    id = user.Id,
                    name = user.Name,
                    email = user.Email
                }
            });
        }
    }
}

