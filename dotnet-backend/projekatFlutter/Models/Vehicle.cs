using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projekatFlutter.Models
{
    public class Vehicle:IEntity<int>
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(20)]
        public string RegistrationNumber { get; set; } = string.Empty;

        [MaxLength(17)]
        public string? VIN { get; set; }

        [Required]
        [MaxLength(50)]
        public string Make { get; set; } = string.Empty;

        [Required]
        [MaxLength(50)]
        public string Model { get; set; } = string.Empty;

        [Required]
        public int Year { get; set; }

        [Required]
        [MaxLength(50)]
        public string VehicleType { get; set; } = string.Empty;

        [Required]
        [MaxLength(30)]
        public string FuelType { get; set; } = string.Empty;

        [Column(TypeName = "decimal(8,2)")]
        public decimal? FuelTankCapacity { get; set; }

        [Column(TypeName = "decimal(10,2)")]
        public decimal? LoadCapacity { get; set; }

        [Required]
        [MaxLength(30)]
        public string Status { get; set; } = "Active";

        [Required]
        public int CurrentOdometer { get; set; } = 0;

        [MaxLength(450)]
        public string? AssignedDriverId { get; set; }

        public DateTime? PurchaseDate { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        // Navigation Properties
        [ForeignKey("AssignedDriverId")]
        public User? AssignedDriver { get; set; }

        public ICollection<VehicleLocation> VehicleLocations { get; set; } = new List<VehicleLocation>();
        public ICollection<Trip> Trips { get; set; } = new List<Trip>();
        public ICollection<ObdReading> ObdReadings { get; set; } = new List<ObdReading>();
        public ICollection<MaintenanceRecord> MaintenanceRecords { get; set; } = new List<MaintenanceRecord>();
        public ICollection<FuelRecord> FuelRecords { get; set; } = new List<FuelRecord>();
        public ICollection<DeviceTracker> DeviceTrackers { get; set; } = new List<DeviceTracker>();
        public ICollection<VehicleGeofence> VehicleGeofences { get; set; } = new List<VehicleGeofence>();
    }
}