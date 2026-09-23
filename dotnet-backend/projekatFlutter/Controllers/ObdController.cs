using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using projekatFlutter.DTO;
using projekatFlutter.Models;
using projekatFlutter.Repositories;
namespace projekatFlutter.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ObdController:BaseApiController<ObdReading, long>
    {
        private readonly HttpClient _httpClient;
        private readonly string _pythonServiceUrl;
        public ObdController(
            IRepository<ObdReading, long> repository,
            IHttpClientFactory httpClientFactory,
            IConfiguration configuration) : base(repository)
        {
            _httpClient = httpClientFactory.CreateClient();
            _pythonServiceUrl = configuration["PythonServiceUrl"] ?? "http://localhost:8000";
        }
        [AllowAnonymous]
        [HttpPost("Track")]
        public async Task<ActionResult<ObdReading>> Track([FromBody] CreateObdReadingDto dto)
        {
            var reading = new ObdReading
            {
                VehicleId = dto.VehicleId,
                DeviceId=dto.DeviceId,
                RPM=dto.RPM,
                Speed = dto.Speed,
                EngineTemp =dto.EngineTemp,
                EngineLoad= dto.EngineLoad,
                FuelLevel = dto.FuelLevel,

                AnomalyScore=null,
                IsAnomaly = null,
                RecordedAt = dto.RecordedAt.HasValue
                    ? DateTime.SpecifyKind(dto.RecordedAt.Value, DateTimeKind.Utc) // Npgsql prima samo UTC
                    : DateTime.UtcNow,
                ReceivedAt = DateTime.UtcNow

            };
            if (dto.RPM.HasValue && dto.Speed.HasValue &&
                dto.EngineTemp.HasValue && dto.EngineLoad.HasValue &&
                dto.FuelLevel.HasValue)
            {
                try
                {
                    var predictRequest = new
                    {
                        rpm = (double)dto.RPM.Value,
                        speed = (double)dto.Speed.Value,
                        engine_temp = (double)dto.EngineTemp.Value,
                        engine_load = (double)dto.EngineLoad.Value,
                        fuel_level = (double)dto.FuelLevel.Value
                    };
                    var response = await _httpClient.PostAsJsonAsync($"{_pythonServiceUrl}/predict", predictRequest);
                    if (response.IsSuccessStatusCode)
                    {
                        var prediction = await response.Content
                            .ReadFromJsonAsync<ObdPredictResponse>();

                        if (prediction != null)
                        {
                            reading.AnomalyScore = prediction.AnomalyScore;
                            reading.IsAnomaly = prediction.IsAnomaly;
                        }
                    }
                }
                catch
                {

                }
            }
                var created = await _repository.CreateAsync(reading);
            return Ok(created);
        }
        [AllowAnonymous]
        [HttpGet("Vehicle/{vehicleId}")]
        public async Task<ActionResult<IEnumerable<ObdReading>>> GetForVehicle(int vehicleId)
        {
            var all=await _repository.GetAllAsync();
            var filtered=all.Where(r=>r.VehicleId == vehicleId).OrderBy(r=>r.RecordedAt).ToList();
            return filtered;
        }
        [AllowAnonymous]
        [HttpGet("Vehicle/{vehicleId}/Trend")]
        public async Task<ActionResult> GetTrend(int vehicleId)
        {
            var all = await _repository.GetAllAsync();
            var data = all.Where(r => r.VehicleId == vehicleId).OrderByDescending(r => r.RecordedAt).Take(10).OrderBy(r => r.RecordedAt)
                           .Select(
                r => new
                {
                    rpm = r.RPM.HasValue ? (double?)r.RPM.Value : null,
                    speed = r.Speed.HasValue ? (double?)r.Speed.Value : null,
                    engine_temp = r.EngineTemp.HasValue ? (double?)r.EngineTemp.Value : null,
                    engine_load = r.EngineLoad.HasValue ? (double?)r.EngineLoad.Value : null,
                    fuel_level = r.FuelLevel.HasValue ? (double?)r.FuelLevel.Value : null,
                }
                ).ToList();
            try
            {
                var response = await _httpClient.PostAsJsonAsync(
                    $"{_pythonServiceUrl}/trend",
                    new { readings = data });

                if (response.IsSuccessStatusCode)
                {
                    var result = await response.Content.ReadFromJsonAsync<object>();
                    return Ok(result);
                }
            }
            catch
            {
                
            }

            return Ok(new { warnings = new[] { "AI trend servis nije dostupan" }, trends = new { } });
        }
    }
}
