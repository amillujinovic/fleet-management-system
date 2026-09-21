class DeviceTracker {
  final int id;
  final String deviceId;
  final String? deviceName;
  final String deviceType;
  final int? vehicleId;
  final bool isActive;
  final int? batteryLevel;
  final int? signalStrength;
  final String? firmwareVersion;
  final DateTime? lastConnectionAt;
  final String? ipAddress;
  final DateTime registeredAt;
  final DateTime updatedAt;

  DeviceTracker({
    required this.id,
    required this.deviceId,
    this.deviceName,
    required this.deviceType,
    this.vehicleId,
    required this.isActive,
    this.batteryLevel,
    this.signalStrength,
    this.firmwareVersion,
    this.lastConnectionAt,
    this.ipAddress,
    required this.registeredAt,
    required this.updatedAt,
  });

  factory DeviceTracker.fromJson(Map<String, dynamic> json) {
    return DeviceTracker(
      id: json['id'] as int,
      deviceId: json['deviceId'] as String,
      deviceName: json['deviceName'] as String?,
      deviceType: json['deviceType'] as String,
      vehicleId: json['vehicleId'] as int?,
      isActive: json['isActive'] as bool,
      batteryLevel: json['batteryLevel'] as int?,
      signalStrength: json['signalStrength'] as int?,
      firmwareVersion: json['firmwareVersion'] as String?,
      lastConnectionAt: json['lastConnectionAt'] != null
          ? DateTime.parse(json['lastConnectionAt'] as String)
          : null,
      ipAddress: json['ipAddress'] as String?,
      registeredAt: DateTime.parse(json['registeredAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deviceId': deviceId,
      'deviceName': deviceName,
      'deviceType': deviceType,
      'vehicleId': vehicleId,
      'isActive': isActive,
      'batteryLevel': batteryLevel,
      'signalStrength': signalStrength,
      'firmwareVersion': firmwareVersion,
      'lastConnectionAt': lastConnectionAt?.toIso8601String(),
      'ipAddress': ipAddress,
      'registeredAt': registeredAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}