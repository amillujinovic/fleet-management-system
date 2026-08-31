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
    public class AlertsController : BaseApiController<Alert, int>
    {
        private readonly ApiDbContext _context;
        public AlertsController(IRepository<Alert, int> repository, ApiDbContext context) : base(repository)
        {
            _context = context;
        }
        [HttpGet("Unread")]
        public async Task<ActionResult> GetUnread()
        {
            var alerts = await _context.Alerts
                .Where(a => a.Status == "New")
                .OrderByDescending(a => a.CreatedAt)
                .ToListAsync();

            return Ok(alerts);
        }
    }
}
