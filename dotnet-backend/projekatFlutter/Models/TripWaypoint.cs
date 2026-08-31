using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projekatFlutter.Models
{
    public class TripWaypoint:IEntity<int>
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int TripId { get; set; }

        [Required]
        public int SequenceNumber { get; set; }

        [Required]
        [MaxLength(100)]
        public string WaypointName { get; set; } = string.Empty;

        [MaxLength(255)]
        public string? Address { get; set; }

        [Required]
        [Column(TypeName = "decimal(10,8)")]
        public decimal Latitude { get; set; }

        [Required]
        [Column(TypeName = "decimal(11,8)")]
        public decimal Longitude { get; set; }

        public DateTime? PlannedArrivalTime { get; set; }
        public DateTime? ActualArrivalTime { get; set; }
        public DateTime? PlannedDepartureTime { get; set; }
        public DateTime? ActualDepartureTime { get; set; }

        [Required]
        [MaxLength(30)]
        public string Status { get; set; } = "Pending";

        [MaxLength(500)]
        public string? Notes { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        // Navigation Properties
        [ForeignKey("TripId")]
        public Trip Trip { get; set; } = null!;
    }
}