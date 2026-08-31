using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using projekatFlutter.Models;
using projekatFlutter.Repositories;

namespace projekatFlutter.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class DeviceTrackersController : BaseApiController<DeviceTracker,int>
    {
        public DeviceTrackersController(IRepository<DeviceTracker,int> repository) : base(repository)
        {
        }
    }
}
