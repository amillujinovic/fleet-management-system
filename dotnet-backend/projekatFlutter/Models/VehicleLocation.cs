using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projekatFlutter.Models
{
    public class VehicleLocation:IEntity<long>
    {
        [Key]
        public long Id { get; set; }

        [Required]
        public int VehicleId { get; set; }

        public int? DeviceId { get; set; }

        [Required]
        [Column(TypeName = "decimal(10,8)")]
        public decimal Latitude { get; set; }

        [Required]
        [Column(TypeName = "decimal(11,8)")]
        public decimal Longitude { get; set; }

        [Column(TypeName = "decimal(8,2)")]
        public decimal? Altitude { get; set; }

        [Column(TypeName = "decimal(6,2)")]
        public decimal? Speed { get; set; }

        [Column(TypeName = "decimal(5,2)")]
        public decimal? Heading { get; set; }

        [Column(TypeName = "decimal(6,2)")]
        public decimal? Accuracy { get; set; }

        public int? Satellites { get; set; }

        [Column(TypeName = "decimal(4,2)")]
        public decimal? HDOP { get; set; }

        public bool? EngineStatus { get; set; }

        [Column(TypeName = "decimal(5,2)")]
        public decimal? FuelLevel { get; set; }

        [Required]
        public DateTime RecordedAt { get; set; } = DateTime.UtcNow;

        [Required]
        public DateTime ReceivedAt { get; set; } = DateTime.UtcNow;

        // Navigation Properties
        [ForeignKey("VehicleId")]
        public Vehicle Vehicle { get; set; } = null!;

        [ForeignKey("DeviceId")]
        public DeviceTracker? Device { get; set; }
    }
}