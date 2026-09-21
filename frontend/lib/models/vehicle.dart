class Vehicle {
  final int id;
  final String registrationNumber;
  final String? vin;
  final String make;
  final String model;
  final int year;
  final String vehicleType;
  final String fuelType;
  final double? fuelTankCapacity;
  final double? loadCapacity;
  final String status;
  final int currentOdometer;
  final String? assignedDriverId;
  final DateTime? purchaseDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  Vehicle({
    required this.id,
    required this.registrationNumber,
    this.vin,
    required this.make,
    required this.model,
    required this.year,
    required this.vehicleType,
    required this.fuelType,
    this.fuelTankCapacity,
    this.loadCapacity,
    required this.status,
    required this.currentOdometer,
    this.assignedDriverId,
    this.purchaseDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] as int,
      registrationNumber: json['registrationNumber'] as String,
      vin: json['vin'] as String?,
      make: json['make'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      vehicleType: json['vehicleType'] as String,
      fuelType: json['fuelType'] as String,
      fuelTankCapacity: json['fuelTankCapacity'] != null
          ? (json['fuelTankCapacity'] as num).toDouble()
          : null,
      loadCapacity: json['loadCapacity'] != null
          ? (json['loadCapacity'] as num).toDouble()
          : null,
      status: json['status'] as String,
      currentOdometer: json['currentOdometer'] as int,
      assignedDriverId: json['assignedDriverId'] as String?,
      purchaseDate: json['purchaseDate'] != null
          ? DateTime.parse(json['purchaseDate'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'registrationNumber': registrationNumber,
      'vin': vin,
      'make': make,
      'model': model,
      'year': year,
      'vehicleType': vehicleType,
      'fuelType': fuelType,
      'fuelTankCapacity': fuelTankCapacity,
      'loadCapacity': loadCapacity,
      'status': status,
      'currentOdometer': currentOdometer,
      'assignedDriverId': assignedDriverId,
      'purchaseDate': purchaseDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}