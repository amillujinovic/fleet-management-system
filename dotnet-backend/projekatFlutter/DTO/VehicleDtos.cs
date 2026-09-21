namespace projekatFlutter.DTOs
{
    public class CreateVehicleDto
    {
        
        public string RegistrationNumber { get; set; } = string.Empty;
        public string? VIN { get; set; }
        public string Make { get; set; } = string.Empty;
        public string Model { get; set; } = string.Empty;
        public int Year { get; set; }
        public string VehicleType { get; set; } = string.Empty;
        public string FuelType { get; set; } = string.Empty;
        public decimal? FuelTankCapacity { get; set; }
        public decimal? LoadCapacity { get; set; }
        public string? AssignedDriverId { get; set; }
        public DateTime? PurchaseDate { get; set; }
    }
    public class UpdateVehicleDto
    {
        public string? Status { get; set; }
        public int? CurrentOdometer { get; set; }
        public string? AssignedDriverId { get; set; }
    }
    public class VehicleDto
    {
        public int Id { get; set; }
        public string RegistrationNumber { get; set; } = string.Empty;
        public string? VIN { get; set; }
        public string Make { get; set; } = string.Empty;
        public string Model { get; set; } = string.Empty;
        public int Year { get; set; }
        public string VehicleType { get; set; } = string.Empty;
        public string FuelType { get; set; } = string.Empty;
        public string Status { get; set; } = string.Empty;
        public int CurrentOdometer { get; set; }
        public string? AssignedDriverId { get; set; }
        public string? AssignedDriverName { get; set; }
        public DateTime CreatedAt { get; set; }
    }
    public class VehicleWithLocationDto : VehicleDto
    {
        public decimal? LastLatitude { get; set; }
        public decimal? LastLongitude { get; set; }
        public decimal? LastSpeed { get; set; }
        public DateTime? LastLocationUpdate { get; set; }
    }
}
