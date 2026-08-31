class Trip {
  final int id;
  final int vehicleId;
  final String driverId;
  final String? tripName;
  final String? startLocation;
  final String? endLocation;
  final double? startLatitude;
  final double? startLongitude;
  final double? endLatitude;
  final double? endLongitude;
  final int? startOdometer;
  final int? endOdometer;
  final double? distanceTraveled;
  final double? fuelConsumed;
  final double? averageFuelConsumption;
  final String status;
  final DateTime? plannedStartTime;
  final DateTime? actualStartTime;
  final DateTime? plannedEndTime;
  final DateTime? actualEndTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  Trip({
    required this.id,
    required this.vehicleId,
    required this.driverId,
    this.tripName,
    this.startLocation,
    this.endLocation,
    this.startLatitude,
    this.startLongitude,
    this.endLatitude,
    this.endLongitude,
    this.startOdometer,
    this.endOdometer,
    this.distanceTraveled,
    this.fuelConsumed,
    this.averageFuelConsumption,
    required this.status,
    this.plannedStartTime,
    this.actualStartTime,
    this.plannedEndTime,
    this.actualEndTime,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Trip.fromJson(Map<String, dynamic> json) {
  return Trip(
    id: json['id'] as int,
    vehicleId: json['vehicleId'] as int,
    driverId: json['driverId'] as String,
    tripName: json['tripName'] as String?,
    startLocation: json['startLocation'] as String?,
    endLocation: json['endLocation'] as String?,
    startLatitude: json['startLatitude'] != null 
        ? (json['startLatitude'] as num).toDouble() 
        : null,
    startLongitude: json['startLongitude'] != null 
        ? (json['startLongitude'] as num).toDouble() 
        : null,
    endLatitude: json['endLatitude'] != null 
        ? (json['endLatitude'] as num).toDouble() 
        : null,
    endLongitude: json['endLongitude'] != null 
        ? (json['endLongitude'] as num).toDouble() 
        : null,
    startOdometer: json['startOdometer'] as int?,
    endOdometer: json['endOdometer'] as int?,
    distanceTraveled: json['distanceTraveled'] != null 
        ? (json['distanceTraveled'] as num).toDouble() 
        : null,
    fuelConsumed: json['fuelConsumed'] != null 
        ? (json['fuelConsumed'] as num).toDouble() 
        : null,
    averageFuelConsumption: json['averageFuelConsumption'] != null 
        ? (json['averageFuelConsumption'] as num).toDouble() 
        : null,
    status: json['status'] as String,
    plannedStartTime: json['plannedStartTime'] != null 
        ? DateTime.parse(json['plannedStartTime'] as String) 
        : null,
    actualStartTime: json['actualStartTime'] != null 
        ? DateTime.parse(json['actualStartTime'] as String) 
        : null,
    plannedEndTime: json['plannedEndTime'] != null 
        ? DateTime.parse(json['plannedEndTime'] as String) 
        : null,
    actualEndTime: json['actualEndTime'] != null 
        ? DateTime.parse(json['actualEndTime'] as String) 
        : null,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> toJson() {
  return {
    'id': id,
    'vehicleId': vehicleId,
    'driverId': driverId,
    'tripName': tripName,
    'startLocation': startLocation,
    'endLocation': endLocation,
    'startLatitude': startLatitude,
    'startLongitude': startLongitude,
    'endLatitude': endLatitude,
    'endLongitude': endLongitude,
    'startOdometer': startOdometer,
    'endOdometer': endOdometer,
    'distanceTraveled': distanceTraveled,
    'fuelConsumed': fuelConsumed,
    'averageFuelConsumption': averageFuelConsumption,
    'status': status,
    'plannedStartTime': plannedStartTime?.toIso8601String(),
    'actualStartTime': actualStartTime?.toIso8601String(),
    'plannedEndTime': plannedEndTime?.toIso8601String(),
    'actualEndTime': actualEndTime?.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}
}