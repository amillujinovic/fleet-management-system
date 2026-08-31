class VehicleLocation {
  final int id;
  final int vehicleId;
  final int? deviceId;
  final double latitude;
  final double longitude;
  final double? altitude;
  final double? speed;
  final double? heading;
  final double? accuracy;
  final int? satellites;
  final double? hdop;
  final bool? engineStatus;
  final double? fuelLevel;
  final DateTime recordedAt;
  final DateTime receivedAt;

  VehicleLocation({
    required this.id,
    required this.vehicleId,
    this.deviceId,
    required this.latitude,
    required this.longitude,
    this.altitude,
    this.speed,
    this.heading,
    this.accuracy,
    this.satellites,
    this.hdop,
    this.engineStatus,
    this.fuelLevel,
    required this.recordedAt,
    required this.receivedAt,
  });

  factory VehicleLocation.fromJson(Map<String, dynamic> json) {
    return VehicleLocation(
      id: json['id'] as int,
      vehicleId: json['vehicleId'] as int,
      deviceId: json['deviceId'] as int?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      altitude: json['altitude'] != null
          ? (json['altitude'] as num).toDouble()
          : null,
      speed: json['speed'] != null
          ? (json['speed'] as num).toDouble()
          : null,
      heading: json['heading'] != null
          ? (json['heading'] as num).toDouble()
          : null,
      accuracy: json['accuracy'] != null
          ? (json['accuracy'] as num).toDouble()
          : null,
      satellites: json['satellites'] as int?,
      hdop: json['hdop'] != null
          ? (json['hdop'] as num).toDouble()
          : null,
      engineStatus: json['engineStatus'] as bool?,
      fuelLevel: json['fuelLevel'] != null
          ? (json['fuelLevel'] as num).toDouble()
          : null,
      recordedAt: DateTime.parse(json['recordedAt'] as String),
      receivedAt: DateTime.parse(json['receivedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'deviceId': deviceId,
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'speed': speed,
      'heading': heading,
      'accuracy': accuracy,
      'satellites': satellites,
      'hdop': hdop,
      'engineStatus': engineStatus,
      'fuelLevel': fuelLevel,
      'recordedAt': recordedAt.toIso8601String(),
      'receivedAt': receivedAt.toIso8601String(),
    };
  }
}