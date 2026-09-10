namespace projekatFlutter.DTO
{
    public class CreateTripDto
    {
        public int VehicleId { get; set; }
        public string DriverId { get; set; } = string.Empty;
        public string? TripName { get; set; }
        public string? StartLocation { get; set; }
        public string? EndLocation { get; set; }
        public DateTime? PlannedStartTime { get; set; }
        public DateTime? PlannedEndTime { get; set; }
    }
    class updateTripDto
    {
        public string? Status { get; set; }
        public int? EndOdometer { get; set; }
        public decimal? FuelConsumed { get; set; }
    }
    public class TripDto
    {
        public int Id { get; set; }
        public int VehicleId { get; set; }
        public string VehicleRegistration { get; set; } = string.Empty;
        public string DriverName { get; set; } = string.Empty;
        public string? TripName { get; set; }
        public string? StartLocation { get; set; }
        public string? EndLocation { get; set; }
        public string Status { get; set; } = string.Empty;
        public DateTime? ActualStartTime { get; set; }
        public DateTime? ActualEndTime { get; set; }
        public decimal? DistanceTraveled { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
