using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projekatFlutter.Models
{
    public class Geofence:IEntity<int>
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(100)]
        public string Name { get; set; } = string.Empty;

        [MaxLength(500)]
        public string? Description { get; set; }

        [Required]
        [MaxLength(20)]
        public string ShapeType { get; set; } = "Circle";

        [Column(TypeName = "decimal(10,8)")]
        public decimal? CenterLatitude { get; set; }

        [Column(TypeName = "decimal(11,8)")]
        public decimal? CenterLongitude { get; set; }

        [Column(TypeName = "decimal(10,2)")]
        public decimal? Radius { get; set; }

        public string? PolygonCoordinates { get; set; }

        [MaxLength(50)]
        public string? ZoneType { get; set; }

        [Required]
        public bool TriggerOnEntry { get; set; } = false;

        [Required]
        public bool TriggerOnExit { get; set; } = false;

        [Required]
        public bool IsActive { get; set; } = true;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        
        public ICollection<VehicleGeofence> VehicleGeofences { get; set; } = new List<VehicleGeofence>();
        public ICollection<Alert> Alerts { get; set; } = new List<Alert>();
    }
}