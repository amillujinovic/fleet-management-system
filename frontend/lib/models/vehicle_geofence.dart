class VehicleGeofence {
  final int id;
  final int vehicleId;
  final int geofenceId;
  final DateTime? enteredAt;
  final DateTime? exitedAt;
  final bool isCurrentlyInside;
  final DateTime createdAt;

  VehicleGeofence({
    required this.id,
    required this.vehicleId,
    required this.geofenceId,
    this.enteredAt,
    this.exitedAt,
    required this.isCurrentlyInside,
    required this.createdAt,
  });

  factory VehicleGeofence.fromJson(Map<String, dynamic> json) {
    return VehicleGeofence(
      id: json['id'] as int,
      vehicleId: json['vehicleId'] as int,
      geofenceId: json['geofenceId'] as int,
      enteredAt: json['enteredAt'] != null
          ? DateTime.parse(json['enteredAt'] as String)
          : null,
      exitedAt: json['exitedAt'] != null
          ? DateTime.parse(json['exitedAt'] as String)
          : null,
      isCurrentlyInside: json['isCurrentlyInside'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'geofenceId': geofenceId,
      'enteredAt': enteredAt?.toIso8601String(),
      'exitedAt': exitedAt?.toIso8601String(),
      'isCurrentlyInside': isCurrentlyInside,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}