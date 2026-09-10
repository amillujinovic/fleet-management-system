using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projekatFlutter.Models
{
    public class ObdReading:IEntity<long>
    {
        [Key]
        public long Id { get; set; }
        [Required]
        public int VehicleId { get; set; }
        public int? DeviceId { get; set; }
        
        public int? RPM { get; set; }
        [Column(TypeName = "decimal(6,2)")]
        public decimal? Speed { get; set; }

        [Column(TypeName = "decimal(5,2)")]
        public decimal? EngineTemp { get; set; }

        [Column(TypeName = "decimal(5,2)")]
        public decimal? EngineLoad { get; set; }

        [Column(TypeName = "decimal(5,2)")]
        public decimal? FuelLevel { get; set; }

        // AI anomaly detection rezultati (Isolation Forest)
        public double? AnomalyScore { get; set; }
        public bool? IsAnomaly { get; set; }

        [Required]
        public DateTime RecordedAt { get; set; } = DateTime.UtcNow;

        [Required]
        public DateTime ReceivedAt { get; set; } = DateTime.UtcNow;

        
        [ForeignKey("VehicleId")]
        public Vehicle Vehicle { get; set; } = null!;

        [ForeignKey("DeviceId")]
        public DeviceTracker? Device { get; set; }
    }
}
