using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projekatFlutter.Models
{
    public class DeviceTracker:IEntity<int>
    {
        [Key]
        public int Id { get; set; }
        [Required]
        [MaxLength(50)]
        public string DeviceId { get; set; } = string.Empty;
        [MaxLength(100)]
        public string? DeviceName { get; set; }

        [Required]
        [MaxLength(50)]
        public string DeviceType { get; set; } = "NodeMCU";
        public int? VehicleId { get; set; }

        [Required]
        public bool IsActive { get; set; } = true;

        public int? BatteryLevel { get; set; }
        public int? SignalStrength { get; set; }

        [MaxLength(20)]
        public string? FirmwareVersion { get; set; }

        public DateTime? LastConnectionAt { get; set; }

        [MaxLength(45)]
        public string? IPAddress { get; set; }

        public DateTime RegisteredAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
        [ForeignKey("VehicleId")]
        public Vehicle? Vehicle { get; set; }

        public ICollection<VehicleLocation> VehicleLocations { get; set; } = new List<VehicleLocation>();
        public ICollection<ObdReading> ObdReadings { get; set; } = new List<ObdReading>();

    }
}
