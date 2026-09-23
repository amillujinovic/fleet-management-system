using projekatFlutter.Models;

namespace projekatFlutter.Data
{
    public static class DbSeeder
    {
        public static void SeedData(ApiDbContext context)
        {
            // Provjeri da li već ima podataka
            if (context.Vehicles.Any())
            {
                return; // Već postoje podaci
            }

            // ═══════════════════════════════════════════════════════════
            // 1. USERS
            // ═══════════════════════════════════════════════════════════
            var users = new List<User>
            {
                new User
                {
                    Id = Guid.NewGuid().ToString(),
                    Email = "marko@test.com",
                    Password = "test123",  
                    Name = "Marko Marković",
 
                },
                new User
                {
                    Id = Guid.NewGuid().ToString(),
                    Email = "petar@test.com",
                    Password = "test123",
                    Name = "Petar Petrović",
                    
                },
                new User
                {
                    Id = Guid.NewGuid().ToString(),
                    Email = "admin@test.com",
                    Password = "admin123",
                    Name = "Admin User",
                    
                }
            };

            // Ne dupliraj korisnike ako je raniji seed pao nakon ovog koraka
            var existingEmails = context.Users.Select(u => u.Email).ToHashSet();
            context.Users.AddRange(users.Where(u => !existingEmails.Contains(u.Email)));
            context.SaveChanges();

            // ═══════════════════════════════════════════════════════════
            // 2. VEHICLES
            // ═══════════════════════════════════════════════════════════
            var vehicles = new List<Vehicle>
            {
                new Vehicle
                {
                    RegistrationNumber = "SA-123-AB",
                    VIN = "WDB9634321L123456",
                    Make = "Mercedes-Benz",
                    Model = "Actros",
                    Year = 2020,
                    VehicleType = "Truck",  // ← ISPRAVLJENO
                    FuelType = "Diesel",
                    Status = "Active",
                    CurrentOdometer = 125000,
                    FuelTankCapacity = 400,
                    LoadCapacity = 18000,
                    AssignedDriverId = users[0].Id,
                    PurchaseDate = new DateTime(2020, 3, 15, 0, 0, 0, DateTimeKind.Utc),
                    CreatedAt = DateTime.UtcNow
                },
                new Vehicle
                {
                    RegistrationNumber = "SA-456-CD",
                    VIN = "WDB9634321L654321",
                    Make = "Volvo",
                    Model = "FH16",
                    Year = 2019,
                    VehicleType = "Truck",  // ← ISPRAVLJENO
                    FuelType = "Diesel",
                    Status = "Active",
                    CurrentOdometer = 230000,
                    FuelTankCapacity = 380,
                    LoadCapacity = 20000,
                    AssignedDriverId = users[1].Id,
                    PurchaseDate = new DateTime(2019, 6, 20, 0, 0, 0, DateTimeKind.Utc),
                    CreatedAt = DateTime.UtcNow.AddMonths(-6)
                },
                new Vehicle
                {
                    RegistrationNumber = "SA-789-EF",
                    VIN = "WMAN12345L789012",
                    Make = "MAN",
                    Model = "TGX",
                    Year = 2018,
                    VehicleType = "Truck",  // ← ISPRAVLJENO
                    FuelType = "Diesel",
                    Status = "Maintenance",
                    CurrentOdometer = 345000,
                    FuelTankCapacity = 390,
                    LoadCapacity = 19000,
                    AssignedDriverId = null,  // Nema vozača
                    PurchaseDate = new DateTime(2018, 1, 10, 0, 0, 0, DateTimeKind.Utc),
                    CreatedAt = DateTime.UtcNow.AddYears(-1)
                },
                new Vehicle
                {
                    RegistrationNumber = "SA-111-GH",
                    VIN = "WVWZZZ1JZXW123456",
                    Make = "Volkswagen",
                    Model = "Caddy",
                    Year = 2021,
                    VehicleType = "Van",  // ← ISPRAVLJENO
                    FuelType = "Diesel",
                    Status = "Active",
                    CurrentOdometer = 45000,
                    FuelTankCapacity = 60,
                    LoadCapacity = 800,
                    AssignedDriverId = users[0].Id,
                    PurchaseDate = new DateTime(2021, 9, 5, 0, 0, 0, DateTimeKind.Utc),
                    CreatedAt = DateTime.UtcNow.AddMonths(-3)
                },
                new Vehicle
                {
                    RegistrationNumber = "SA-222-IJ",
                    Make = "Iveco",
                    Model = "Eurocargo",
                    Year = 2017,
                    VehicleType = "Truck",  // ← ISPRAVLJENO
                    FuelType = "Diesel",
                    Status = "OutOfService",
                    CurrentOdometer = 520000,
                    FuelTankCapacity = 300,
                    LoadCapacity = 12000,
                    AssignedDriverId = null,
                    PurchaseDate = new DateTime(2017, 4, 12, 0, 0, 0, DateTimeKind.Utc),
                    CreatedAt = DateTime.UtcNow.AddYears(-2)
                }
            };

            context.Vehicles.AddRange(vehicles);
            context.SaveChanges();

            // ═══════════════════════════════════════════════════════════
            // 3. TRIPS
            // ═══════════════════════════════════════════════════════════
            var trips = new List<Trip>
            {
                new Trip
                {
                    VehicleId = vehicles[0].Id,
                    DriverId = users[0].Id,
                    TripName = "Dostava Sarajevo → Mostar",
                    StartLocation = "Sarajevo",
                    EndLocation = "Mostar",
                    Status = "Completed",
                    PlannedStartTime = DateTime.UtcNow.AddDays(-2).AddHours(-1),
                    ActualStartTime = DateTime.UtcNow.AddDays(-2),
                    PlannedEndTime = DateTime.UtcNow.AddDays(-2).AddHours(2),
                    ActualEndTime = DateTime.UtcNow.AddDays(-2),
                    StartOdometer = 123000,
                    EndOdometer = 123130,
                    DistanceTraveled = 130,
                    StartLatitude = 43.8563m,
                    StartLongitude = 18.4131m,
                    EndLatitude = 43.3438m,
                    EndLongitude = 17.8078m,
                    FuelConsumed = 35,
                    CreatedAt = DateTime.UtcNow.AddDays(-3)
                },
                new Trip
                {
                    VehicleId = vehicles[0].Id,
                    DriverId = users[0].Id,
                    TripName = "Dostava Sarajevo → Tuzla",
                    StartLocation = "Sarajevo",
                    EndLocation = "Tuzla",
                    Status = "InProgress",
                    PlannedStartTime = DateTime.UtcNow.AddHours(-2),
                    ActualStartTime = DateTime.UtcNow.AddHours(-1),
                    StartOdometer = 125000,
                    StartLatitude = 43.8563m,
                    StartLongitude = 18.4131m,
                    CreatedAt = DateTime.UtcNow.AddHours(-2)
                },
                new Trip
                {
                    VehicleId = vehicles[1].Id,
                    DriverId = users[1].Id,
                    TripName = "Transport Banja Luka → Bihać",
                    StartLocation = "Banja Luka",
                    EndLocation = "Bihać",
                    Status = "Completed",
                    PlannedStartTime = DateTime.UtcNow.AddDays(-5),
                    ActualStartTime = DateTime.UtcNow.AddDays(-5),
                    PlannedEndTime = DateTime.UtcNow.AddDays(-5).AddHours(3),
                    ActualEndTime = DateTime.UtcNow.AddDays(-5),
                    StartOdometer = 228000,
                    EndOdometer = 228180,
                    DistanceTraveled = 180,
                    FuelConsumed = 48,
                    CreatedAt = DateTime.UtcNow.AddDays(-6)
                },
                new Trip
                {
                    VehicleId = vehicles[3].Id,  // Van
                    DriverId = users[0].Id,
                    TripName = "Lokalna dostava Sarajevo",
                    StartLocation = "Sarajevo - Centar",
                    EndLocation = "Sarajevo - Ilidža",
                    Status = "Planned",
                    PlannedStartTime = DateTime.UtcNow.AddHours(3),
                    PlannedEndTime = DateTime.UtcNow.AddHours(4),
                    CreatedAt = DateTime.UtcNow
                }
            };

            context.Trips.AddRange(trips);
            context.SaveChanges();

            // ═══════════════════════════════════════════════════════════
            // 4. MAINTENANCE RECORDS
            // ═══════════════════════════════════════════════════════════
            var maintenance = new List<MaintenanceRecord>
            {
                new MaintenanceRecord
                {
                    VehicleId = vehicles[2].Id,  // MAN TGX (Maintenance status)
                   
                    Description = "Redovna zamjena ulja i filtera",
                    Status = "Pending",
                    ScheduledDate = DateTime.UtcNow.AddDays(2),
                    CreatedAt = DateTime.UtcNow.AddDays(-3)
                },
                new MaintenanceRecord
                {
                    VehicleId = vehicles[0].Id,  // Mercedes Actros
                    Description = "Rotacija guma i provjera pritiska",
                    Status = "Completed",
                    ScheduledDate = DateTime.UtcNow.AddDays(-10),
                    CompletedDate = DateTime.UtcNow.AddDays(-10),
                    CreatedAt = DateTime.UtcNow.AddDays(-15)
                },
                new MaintenanceRecord
                {
                    VehicleId = vehicles[1].Id,  // Volvo FH16
                    Description = "Godišnji tehnički pregled",
                    Status = "Scheduled",
                    ScheduledDate = DateTime.UtcNow.AddDays(15),
                    CreatedAt = DateTime.UtcNow.AddDays(-5)
                },
                new MaintenanceRecord
                {
                    VehicleId = vehicles[2].Id,  // MAN TGX
                    Description = "Kompletan servis kočionog sistema",
                    Status = "Pending",
                    ScheduledDate = DateTime.UtcNow.AddDays(3),
                    CreatedAt = DateTime.UtcNow.AddDays(-2)
                },
                new MaintenanceRecord
                {
                    VehicleId = vehicles[4].Id,  // Iveco (OutOfService)
                    Description = "Generalni remont motora - izvan upotrebe",
                    Status = "InProgress",
                    ScheduledDate = DateTime.UtcNow.AddDays(-7),
                    CreatedAt = DateTime.UtcNow.AddDays(-10)
                }
            };

            context.MaintenanceRecords.AddRange(maintenance);
            context.SaveChanges();

            // ═══════════════════════════════════════════════════════════
            // 5. FUEL RECORDS
            // ═══════════════════════════════════════════════════════════
            var fuelRecords = new List<FuelRecord>
            {
                new FuelRecord
                {
                    VehicleId = vehicles[0].Id,
                    FuelType = "Diesel",
                    Location = "Petrol Sarajevo",
                   },
                new FuelRecord
                {
                    VehicleId = vehicles[1].Id,
                    FuelType = "Diesel",
                    Location = "INA Banja Luka",
                    },
                new FuelRecord
                {
                    VehicleId = vehicles[3].Id,  // Van
                    FuelType = "Diesel",
                    Location = "Petrol Ilidža",
                   }
            };

            context.FuelRecords.AddRange(fuelRecords);
            context.SaveChanges();

            // ═══════════════════════════════════════════════════════════
            // 6. ALERTS
            // ═══════════════════════════════════════════════════════════
            var alerts = new List<Alert>
            {
                new Alert
                {
                    VehicleId = vehicles[2].Id,  // MAN TGX
                    AlertType = "Maintenance Due",
                    Severity = "Medium",
                    Message = "Oil change required for SA-789-EF (MAN TGX)",
                    Status = "New",
                    CreatedAt = DateTime.UtcNow.AddHours(-2)
                },
                new Alert
                {
                    VehicleId = vehicles[4].Id,  // Iveco
                    AlertType = "Vehicle Out of Service",
                    Severity = "High",
                    Message = "SA-222-IJ (Iveco) is out of service - engine overhaul in progress",
                    Status = "New",
                    CreatedAt = DateTime.UtcNow.AddDays(-7)
                },
                new Alert
                {
                    VehicleId = vehicles[1].Id,  // Volvo
                    AlertType = "Inspection Due",
                    Severity = "Low",
                    Message = "Annual inspection due in 15 days for SA-456-CD (Volvo FH16)",
                    Status = "New",
                    CreatedAt = DateTime.UtcNow.AddDays(-1)
                },
                new Alert
                {
                    VehicleId = vehicles[0].Id,  // Mercedes
                    AlertType = "High Mileage",
                    Severity = "Low",
                    Message = "Vehicle SA-123-AB has reached 125,000 km",
                    Status = "Acknowledged",
                    CreatedAt = DateTime.UtcNow.AddDays(-5)
                }
            };

            context.Alerts.AddRange(alerts);
            context.SaveChanges();

            // ═══════════════════════════════════════════════════════════
            // 7. GEOFENCES (OPCIONO)
            // ═══════════════════════════════════════════════════════════
            var geofences = new List<Geofence>
            {
                new Geofence
                {
                    Name = "Sarajevo Depot",
                    CenterLatitude = 43.8563m,
                    CenterLongitude = 18.4131m,
                    Radius = 500,  // 500 metara
                    IsActive = true,
                    CreatedAt = DateTime.UtcNow.AddMonths(-6)
                },
                new Geofence
                {
                    Name = "Mostar Warehouse",
                    CenterLatitude = 43.3438m,
                    CenterLongitude = 17.8078m,
                    Radius = 300,
                    IsActive = true,
                    CreatedAt = DateTime.UtcNow.AddMonths(-4)
                }
            };

            context.Geofences.AddRange(geofences);
            context.SaveChanges();

            // ═══════════════════════════════════════════════════════════
            // 8. DEVICE TRACKERS (OPCIONO)
            // ═══════════════════════════════════════════════════════════
            var deviceTrackers = new List<DeviceTracker>
            {
                new DeviceTracker
                {
                    DeviceId = "NODE_MCU_001",
                    DeviceName = "GPS Tracker 1",
                    DeviceType = "NodeMCU_GPS",
                    VehicleId = vehicles[0].Id,
                    IsActive = true,
                    LastConnectionAt = DateTime.UtcNow.AddMinutes(-5),
                   },
                new DeviceTracker
                {
                    DeviceId = "NODE_MCU_002",
                    DeviceName = "GPS Tracker 2",
                    DeviceType = "NodeMCU_GPS",
                    VehicleId = vehicles[1].Id,
                    IsActive = true,
                    LastConnectionAt = DateTime.UtcNow.AddMinutes(-10),
                    }
            };

            context.DeviceTrackers.AddRange(deviceTrackers);
            context.SaveChanges();
        }
    }
}