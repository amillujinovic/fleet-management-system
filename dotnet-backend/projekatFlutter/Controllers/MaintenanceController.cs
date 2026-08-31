using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using projekatFlutter.Data;
using projekatFlutter.Models;
using projekatFlutter.Repositories;

namespace projekatFlutter.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class MaintenanceController : BaseApiController<MaintenanceRecord, int>
    {
        private readonly ApiDbContext _context;
        public MaintenanceController(IRepository<MaintenanceRecord,int> repository,ApiDbContext context):base(repository)
        {
            _context = context;
        }
        public override async Task<ActionResult<IEnumerable<MaintenanceRecord>>> GetAll()
        {
            var records = await _context.MaintenanceRecords
                .Include(m => m.Vehicle)
                .OrderByDescending(m => m.ScheduledDate)
                .ToListAsync();

            return Ok(records);
        }

        
        [HttpGet("Vehicle/{vehicleId}")]
        public async Task<ActionResult> GetByVehicle(int vehicleId)
        {
            var records = await _context.MaintenanceRecords
                .Where(m => m.VehicleId == vehicleId)
                .OrderByDescending(m => m.ScheduledDate)
                .ToListAsync();

            return Ok(records);
        }

        
        [HttpGet("Upcoming")]
        public async Task<ActionResult> GetUpcoming()
        {
            var records = await _context.MaintenanceRecords
                .Include(m => m.Vehicle)
                .Where(m => m.Status == "Pending" || m.Status == "Scheduled")
                .OrderBy(m => m.ScheduledDate)
                .ToListAsync();

            return Ok(records);
        }
    }
}
