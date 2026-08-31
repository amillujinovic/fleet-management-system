using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using projekatFlutter.Data;
using projekatFlutter.DTOs;
using projekatFlutter.Models;
using projekatFlutter.Repositories;

namespace projekatFlutter.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class VehiclesController : BaseApiController<Vehicle, int>
    {
        private readonly ApiDbContext _context;

        public VehiclesController(IRepository<Vehicle, int> repository, ApiDbContext context) : base(repository)
        {
            _context = context;
        }
        [HttpGet("ByStatus")]
        public async Task<ActionResult<IEnumerable<Vehicle>>> GetByStatus([FromQuery] string status)
        {
            var vehicles = await _context.Vehicles
                .Where(v => v.Status == status)
                .ToListAsync();
            return Ok(vehicles);
        }
        [HttpGet("WithDrivers")]
        public async Task<ActionResult> GetWithDrivers()
        {
            var vehicles = await _context.Vehicles.Include(v => v.AssignedDriver).Where(v => v.AssignedDriverId != null).ToListAsync();
            return Ok(vehicles);
        }
        [HttpGet("Statistics")]
        public async Task<ActionResult> GetStatistics()
        {
            var statistics = new
            {
                totalVehicles = await _context.Vehicles.CountAsync(),
                active=await _context.Vehicles.CountAsync(v=>v.Status == "Active"),
                maintenance=await _context.Vehicles.CountAsync(v => v.Status == "Maintenance"),
                averageOdometer=await _context.Vehicles.AverageAsync(v=>(double)v.CurrentOdometer),

            };
            return Ok(statistics);
        }

    }

}