using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using projekatFlutter.Data;
using projekatFlutter.DTOs;
using projekatFlutter.Models;

namespace projekatFlutter.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class GpsController : ControllerBase
    {
        private readonly ApiDbContext _context;

        public GpsController(ApiDbContext context)
        {
            _context = context;
        }
        [AllowAnonymous]
        // POST: api/Gps/Track
        [HttpPost("Track")]
        public async Task<ActionResult> ReceiveGpsData(GpsDataDto dto)
        {
            var vehicle = await _context.Vehicles.FindAsync(dto.VehicleId);
            if (vehicle == null)
            {
                return BadRequest(new { message = "Vehicle not found" });
            }

            int? deviceId = null;
            if (!string.IsNullOrEmpty(dto.DeviceId))
            {
                var device = await _context.DeviceTrackers.FirstOrDefaultAsync(d => d.DeviceId == dto.DeviceId);

                if (device != null)
                {
                    deviceId = device.Id;
                    device.LastConnectionAt = DateTime.UtcNow;
                    device.UpdatedAt = DateTime.UtcNow;
                }
            }

            var location = new VehicleLocation
            {
                VehicleId = dto.VehicleId,
                DeviceId = deviceId,
                Latitude = dto.Latitude,
                Longitude = dto.Longitude,
                Altitude = dto.Altitude,
                Speed = dto.Speed,
                Heading = dto.Heading,
                Accuracy = dto.Accuracy,
                Satellites = dto.Satellites,
                EngineStatus = dto.EngineStatus,
                FuelLevel = dto.FuelLevel,
                RecordedAt = dto.RecordedAt ?? DateTime.UtcNow,
                ReceivedAt = DateTime.UtcNow
            };

            _context.VehicleLocations.Add(location);
            await _context.SaveChangesAsync();

            return Ok(new { message = "GPS data received successfully", locationId = location.Id, timestamp = location.ReceivedAt });
        }

        // GET: api/Gps/Vehicle/5/Latest
        [HttpGet("Vehicle/{vehicleId}/Latest")]
        public async Task<ActionResult<VehicleLocationDto>> GetLatestLocation(int vehicleId)
        {
            var location = await _context.VehicleLocations
                .Include(vl => vl.Vehicle)
                .Where(vl => vl.VehicleId == vehicleId)
                .OrderByDescending(vl => vl.RecordedAt)
                .Select(vl => new VehicleLocationDto
                {
                    Id = vl.Id,
                    VehicleId = vl.VehicleId,
                    VehicleRegistration = vl.Vehicle.RegistrationNumber,
                    Latitude = vl.Latitude,
                    Longitude = vl.Longitude,
                    Speed = vl.Speed,
                    Heading = vl.Heading,
                    EngineStatus = vl.EngineStatus,
                    RecordedAt = vl.RecordedAt
                })
                .FirstOrDefaultAsync();

            if (location == null)
            {
                return NotFound(new { message = "No location data found for this vehicle" });
            }

            return Ok(location);
        }

        // POST: api/Gps/Vehicle/History
        [HttpPost("Vehicle/History")]
        public async Task<ActionResult<IEnumerable<VehicleLocationDto>>> GetLocationHistory(LocationHistoryRequest request)
        {
            var query = _context.VehicleLocations.Include(vl => vl.Vehicle).Where(vl => vl.VehicleId == request.VehicleId).AsQueryable();

            if (request.StartDate.HasValue)
            {
                query = query.Where(vl => vl.RecordedAt >= request.StartDate.Value);
            }

            if (request.EndDate.HasValue)
            {
                query = query.Where(vl => vl.RecordedAt <= request.EndDate.Value);
            }

            var locations = await query
                .OrderByDescending(vl => vl.RecordedAt)
                .Take(request.MaxResults)
                .Select(vl => new VehicleLocationDto
                {
                    Id = vl.Id,
                    VehicleId = vl.VehicleId,
                    VehicleRegistration = vl.Vehicle.RegistrationNumber,
                    Latitude = vl.Latitude,
                    Longitude = vl.Longitude,
                    Speed = vl.Speed,
                    Heading = vl.Heading,
                    EngineStatus = vl.EngineStatus,
                    RecordedAt = vl.RecordedAt
                })
                .ToListAsync();

            return Ok(locations);
        }

        // GET: api/Gps/Live
        [HttpGet("Live")]
        public async Task<ActionResult<IEnumerable<VehicleLocationDto>>> GetLiveLocations()
        {
            var latestLocations = await _context.VehicleLocations
                .Include(vl => vl.Vehicle)
                .Where(vl => vl.Vehicle.Status == "Active")
                .GroupBy(vl => vl.VehicleId)
                .Select(g => g.OrderByDescending(vl => vl.RecordedAt).FirstOrDefault())
                .Where(vl => vl != null)
                .Select(vl => new VehicleLocationDto
                {
                    Id = vl!.Id,
                    VehicleId = vl.VehicleId,
                    VehicleRegistration = vl.Vehicle.RegistrationNumber,
                    Latitude = vl.Latitude,
                    Longitude = vl.Longitude,
                    Speed = vl.Speed,
                    Heading = vl.Heading,
                    EngineStatus = vl.EngineStatus,
                    RecordedAt = vl.RecordedAt
                })
                .ToListAsync();

            return Ok(latestLocations);
        }

        // DELETE: api/Gps/Vehicle/5/ClearHistory
        [HttpDelete("Vehicle/{vehicleId}/ClearHistory")]
        public async Task<ActionResult> ClearOldData(int vehicleId, [FromQuery] int daysToKeep = 30)
        {
            var cutoffDate = DateTime.UtcNow.AddDays(-daysToKeep);

            var oldLocations = _context.VehicleLocations.Where(vl => vl.VehicleId == vehicleId && vl.RecordedAt < cutoffDate);

            var count = await oldLocations.CountAsync();
            _context.VehicleLocations.RemoveRange(oldLocations);
            await _context.SaveChangesAsync();

            return Ok(new { message = $"Deleted {count} old location records", deletedCount = count });
        }
    }
}