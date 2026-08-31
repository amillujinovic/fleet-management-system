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
    public class FuelRecordsController : BaseApiController<FuelRecord,int>
    {
        public FuelRecordsController(IRepository<FuelRecord, int> repository) : base(repository)
        {
        }
    }
}
