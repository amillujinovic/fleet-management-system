using System.ComponentModel.DataAnnotations;
using projekatFlutter.Models;
using System.ComponentModel.DataAnnotations.Schema;
namespace projekatFlutter.Models
{
    public class DriversNote : IEntity<int>
    {
        [Key]
        public int Id { get; set; }
        [Required]
        public int VehicleId { get; set; }
        [Required]
        public string Note { get; set; } = null!;
        
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        [ForeignKey("VehicleId")]
        public Vehicle Vehicle { get; set; } = null!;
    }
}
