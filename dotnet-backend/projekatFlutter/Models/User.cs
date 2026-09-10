namespace projekatFlutter.Models
{
    public class User:IEntity<string>
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public string Email { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public string? vehicleType { get; set; } //optional data
    }
}
