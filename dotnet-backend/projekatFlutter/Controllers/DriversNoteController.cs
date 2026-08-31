using Microsoft.AspNetCore.Mvc;
using projekatFlutter.DTO;
using projekatFlutter.Models;
using projekatFlutter.Repositories;
namespace projekatFlutter.Controllers
{
    public class DriversNoteController:BaseApiController<DriversNote, int>
    {
        public DriversNoteController(IRepository<DriversNote, int> repository) : base(repository)
        {
        }
        [HttpPost("Notes")]
        public async Task<ActionResult<DriversNote>> CreateNote([FromBody] CreateDriversNoteDto dto)
        {
            var note = new DriversNote
            {
                VehicleId = dto.vehicleId,
                Note = dto.note,
                CreatedAt = DateTime.UtcNow
            };
            var created = await _repository.CreateAsync(note);
            return Ok(created);
        }
    }
}
