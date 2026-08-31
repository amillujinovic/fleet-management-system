namespace projekatFlutter.DTOs
{
    public class GpsDataDto
    {
        public int VehicleId { get; set; }
        public string? DeviceId { get; set; }
        public decimal Latitude { get; set; }
        public decimal Longitude { get; set; }
        public decimal? Altitude { get; set; }
        public decimal? Speed { get; set; }
        public decimal? Heading { get; set; }
        public decimal? Accuracy { get; set; }
        public int? Satellites { get; set; }
        public bool? EngineStatus { get; set; }
        public decimal? FuelLevel { get; set; }
        public DateTime? RecordedAt { get; set; }
    }

    public class VehicleLocationDto
    {
        public long Id { get; set; }
        public int VehicleId { get; set; }
        public string? VehicleRegistration { get; set; }
        public decimal Latitude { get; set; }
        public decimal Longitude { get; set; }
        public decimal? Speed { get; set; }
        public decimal? Heading { get; set; }
        public bool? EngineStatus { get; set; }
        public DateTime RecordedAt { get; set; }
    }

    public class LocationHistoryRequest
    {
        public int VehicleId { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public int MaxResults { get; set; } = 100;
    }
}