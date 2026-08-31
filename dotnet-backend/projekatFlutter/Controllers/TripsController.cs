using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using projekatFlutter.Data;
using projekatFlutter.DTO;
using projekatFlutter.Models;
using projekatFlutter.Repositories;

namespace projekatFlutter.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class TripsController : BaseApiController<Trip, int>
    {
        private readonly ApiDbContext _context;
        public TripsController(IRepository<Trip, int> repository, ApiDbContext context) : base(repository)
        {
            _context = context;
        }
        public override async Task<ActionResult<IEnumerable<Trip>>> GetAll()
        {
            var trips = await _context.Trips
                .Include(t => t.Vehicle)
                .Include(t => t.Driver)
                .OrderByDescending(t => t.ActualStartTime)
                .ToListAsync();

            return Ok(trips);
        }
        [HttpGet("Vehicle/{vehicleId}")]
        public async Task<ActionResult<IEnumerable<Trip>>> GetByVehicle(int vehicleId)
        {
            var trips = await _context.Trips
               .Include(t => t.Driver)
               .Where(t => t.VehicleId == vehicleId)
               .OrderByDescending(t => t.ActualStartTime)
               .ToListAsync();

            return Ok(trips);
        }
        [HttpGet("Active")]
        public async Task<ActionResult> GetActive()
        {
            var trips = await _context.Trips
                .Include(t => t.Vehicle)
                .Include(t => t.Driver)
                .Where(t => t.Status == "InProgress")
                .ToListAsync();

            return Ok(trips);
        }
    }
}
