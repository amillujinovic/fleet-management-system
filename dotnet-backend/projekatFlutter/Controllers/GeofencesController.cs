using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using projekatFlutter.Models;
using projekatFlutter.Repositories;

namespace projekatFlutter.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class GeofencesController : BaseApiController<Geofence, int>
    {
        public GeofencesController(IRepository<Geofence, int> repository)
            : base(repository)
        {
        }
    }
}