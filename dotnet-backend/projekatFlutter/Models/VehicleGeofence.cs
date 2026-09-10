using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projekatFlutter.Models
{
    public class VehicleGeofence:IEntity<int>
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int VehicleId { get; set; }

        [Required]
        public int GeofenceId { get; set; }

        public DateTime? EnteredAt { get; set; }
        public DateTime? ExitedAt { get; set; }

        [Required]
        public bool IsCurrentlyInside { get; set; } = false;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        
        [ForeignKey("VehicleId")]
        public Vehicle Vehicle { get; set; } = null!;

        [ForeignKey("GeofenceId")]
        public Geofence Geofence { get; set; } = null!;
    }
}