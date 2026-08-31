using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projekatFlutter.Models
{
    public class Alert:IEntity<int>
    {
        [Key]
        public int Id { get; set; }
        
        public int? VehicleId { get; set; }

        [MaxLength(450)]
        public string? DriverId { get; set; }

        public int? TripId { get; set; }

        public int? GeofenceId { get; set; }

        [Required]
        [MaxLength(50)]
        public string AlertType { get; set; } = string.Empty;

        [Required]
        [MaxLength(20)]
        public string Severity { get; set; } = "Info";

        [Required]
        [MaxLength(200)]
        public string Title { get; set; } = string.Empty;

        [Required]
        [MaxLength(1000)]
        public string Message { get; set; } = string.Empty;

        [Column(TypeName = "decimal(10,8)")]
        public decimal? Latitude { get; set; }

        [Column(TypeName = "decimal(11,8)")]
        public decimal? Longitude { get; set; }

        public string? MetaData { get; set; }

        [Required]
        [MaxLength(30)]
        public string Status { get; set; } = "New";

        [MaxLength(450)]
        public string? AcknowledgedBy { get; set; }

        public DateTime? AcknowledgedAt { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        
        [ForeignKey("VehicleId")]
        public Vehicle? Vehicle { get; set; }

        [ForeignKey("DriverId")]
        public User? Driver { get; set; }

        [ForeignKey("TripId")]
        public Trip? Trip { get; set; }

        [ForeignKey("GeofenceId")]
        public Geofence? Geofence { get; set; }

        [ForeignKey("AcknowledgedBy")]
        public User? AcknowledgedByUser { get; set; }
    }
}