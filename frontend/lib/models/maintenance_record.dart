class MaintenanceRecord {
  final int id;
  final int vehicleId;
  final String maintenanceType;
  final String description;
  final double? cost;
  final String currency;
  final int? odometerReading;
  final String? serviceProvider;
  final String? performedBy;
  final DateTime? scheduledDate;
  final DateTime? completedDate;
  final String status;
  final DateTime? nextServiceDate;
  final int? nextServiceOdometer;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  MaintenanceRecord({
    required this.id,
    required this.vehicleId,
    required this.maintenanceType,
    required this.description,
    this.cost,
    required this.currency,
    this.odometerReading,
    this.serviceProvider,
    this.performedBy,
    this.scheduledDate,
    this.completedDate,
    required this.status,
    this.nextServiceDate,
    this.nextServiceOdometer,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  factory MaintenanceRecord.fromJson(Map<String,dynamic> json)
  {
    return MaintenanceRecord(id: json['Id'], vehicleId: json['VehicleId'], maintenanceType: json['MaintenanceType'], description: json['Description'],cost:json['Cost'] ,currency: json['Currency'],odometerReading: json['OdometerReading'],serviceProvider: json['ServiceProvider'],performedBy: json['PerformedBy'] ,scheduledDate: json['ScheduledDate'],completedDate: json['CompletedDate'],status: json['Status'],nextServiceDate: json['NextServiceDate'],nextServiceOdometer: json['NextServiceOdometer'],notes: json['Notes'] ,createdAt: json['CreatedAt'], updatedAt: json['UpdatedAt']);
  }
  Map<String, dynamic> toJson() {
  return {
    'id': id,
    'vehicleId': vehicleId,
    'maintenanceType': maintenanceType,
    'description': description,
    'cost': cost,
    'currency': currency,
    'odometerReading': odometerReading,
    'serviceProvider': serviceProvider,
    'performedBy': performedBy,
    'scheduledDate': scheduledDate?.toIso8601String(),
    'completedDate': completedDate?.toIso8601String(),
    'status': status,
    'nextServiceDate': nextServiceDate?.toIso8601String(),
    'nextServiceOdometer': nextServiceOdometer,
    'notes': notes,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}
}