using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projekatFlutter.Models
{
    public class MaintenanceRecord:IEntity<int>
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int VehicleId { get; set; }

        [Required]
        [MaxLength(50)]
        public string MaintenanceType { get; set; } = string.Empty;

        [Required]
        [MaxLength(500)]
        public string Description { get; set; } = string.Empty;

        [Column(TypeName = "decimal(10,2)")]
        public decimal? Cost { get; set; }

        [MaxLength(3)]
        public string Currency { get; set; } = "BAM";

        public int? OdometerReading { get; set; }

        [MaxLength(100)]
        public string? ServiceProvider { get; set; }

        [MaxLength(100)]
        public string? PerformedBy { get; set; }

        public DateTime? ScheduledDate { get; set; }
        public DateTime? CompletedDate { get; set; }

        [Required]
        [MaxLength(30)]
        public string Status { get; set; } = "Scheduled";

        public DateTime? NextServiceDate { get; set; }
        public int? NextServiceOdometer { get; set; }

        [MaxLength(1000)]
        public string? Notes { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        // Navigation Properties
        [ForeignKey("VehicleId")]
        public Vehicle Vehicle { get; set; } = null!;
    }
}