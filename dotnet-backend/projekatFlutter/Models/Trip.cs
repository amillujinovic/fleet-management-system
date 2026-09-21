using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projekatFlutter.Models
{
    public class Trip:IEntity<int>
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int VehicleId { get; set; }

        [Required]
        [MaxLength(450)]
        public string DriverId { get; set; } = string.Empty;

        [MaxLength(100)]
        public string? TripName { get; set; }

        [MaxLength(255)]
        public string? StartLocation { get; set; }

        [MaxLength(255)]
        public string? EndLocation { get; set; }

        [Column(TypeName = "decimal(10,8)")]
        public decimal? StartLatitude { get; set; }

        [Column(TypeName = "decimal(11,8)")]
        public decimal? StartLongitude { get; set; }

        [Column(TypeName = "decimal(10,8)")]
        public decimal? EndLatitude { get; set; }

        [Column(TypeName = "decimal(11,8)")]
        public decimal? EndLongitude { get; set; }

        public int? StartOdometer { get; set; }
        public int? EndOdometer { get; set; }

        [Column(TypeName = "decimal(10,2)")]
        public decimal? DistanceTraveled { get; set; }

        [Column(TypeName = "decimal(8,2)")]
        public decimal? FuelConsumed { get; set; }

        [Column(TypeName = "decimal(5,2)")]
        public decimal? AverageFuelConsumption { get; set; }

        [Required]
        [MaxLength(30)]
        public string Status { get; set; } = "Planned";

        public DateTime? PlannedStartTime { get; set; }
        public DateTime? ActualStartTime { get; set; }
        public DateTime? PlannedEndTime { get; set; }
        public DateTime? ActualEndTime { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        // Navigation Properties
        [ForeignKey("VehicleId")]
        public Vehicle Vehicle { get; set; } = null!;

        [ForeignKey("DriverId")]
        public User Driver { get; set; } = null!;

        public ICollection<TripWaypoint> TripWaypoints { get; set; } = new List<TripWaypoint>();
        public ICollection<FuelRecord> FuelRecords { get; set; } = new List<FuelRecord>();
    }
}