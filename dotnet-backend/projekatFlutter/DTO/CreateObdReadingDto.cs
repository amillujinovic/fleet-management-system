namespace projekatFlutter.DTO
{
    public class CreateObdReadingDto
    {
        public int VehicleId { get; set; }
        public int? DeviceId { get; set; }

        public int? RPM { get; set; }
        public decimal? Speed { get; set; }
        public decimal? EngineTemp { get; set; }
        public decimal? EngineLoad { get; set; }
        public decimal? FuelLevel { get; set; }

        public DateTime? RecordedAt { get; set; }
    }
}
