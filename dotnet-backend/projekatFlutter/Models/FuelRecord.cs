using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace projekatFlutter.Models
{
    public class FuelRecord:IEntity<int>
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int VehicleId { get; set; }

        [MaxLength(450)]
        public string? DriverId { get; set; }

        public int? TripId { get; set; }

        [Required]
        [MaxLength(30)]
        public string FuelType { get; set; } = string.Empty;

        [Required]
        [Column(TypeName = "decimal(8,2)")]
        public decimal Quantity { get; set; }

        [Required]
        [Column(TypeName = "decimal(8,2)")]
        public decimal UnitPrice { get; set; }

        [Required]
        [Column(TypeName = "decimal(10,2)")]
        public decimal TotalCost { get; set; }

        [MaxLength(3)]
        public string Currency { get; set; } = "BAM";

        public int? OdometerReading { get; set; }

        [MaxLength(255)]
        public string? Location { get; set; }

        [Column(TypeName = "decimal(10,8)")]
        public decimal? Latitude { get; set; }

        [Column(TypeName = "decimal(11,8)")]
        public decimal? Longitude { get; set; }

        [MaxLength(100)]
        public string? FuelStationName { get; set; }

        [MaxLength(50)]
        public string? ReceiptNumber { get; set; }

        [Required]
        public DateTime FilledAt { get; set; } = DateTime.UtcNow;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        // Navigation Properties
        [ForeignKey("VehicleId")]
        public Vehicle Vehicle { get; set; } = null!;

        [ForeignKey("DriverId")]
        public User? Driver { get; set; }

        [ForeignKey("TripId")]
        public Trip? Trip { get; set; }
    }
}