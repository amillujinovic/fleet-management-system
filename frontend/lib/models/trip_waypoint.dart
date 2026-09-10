class TripWaypoint {
  final int id;
  final int tripId;
  final int sequenceNumber;
  final String waypointName;
  final String? address;
  final double latitude;
  final double longitude;
  final DateTime? plannedArrivalTime;
  final DateTime? actualArrivalTime;
  final DateTime? plannedDepartureTime;
  final DateTime? actualDepartureTime;
  final String status;
  final String? notes;
  final DateTime createdAt;

  TripWaypoint({
    required this.id,
    required this.tripId,
    required this.sequenceNumber,
    required this.waypointName,
    this.address,
    required this.latitude,
    required this.longitude,
    this.plannedArrivalTime,
    this.actualArrivalTime,
    this.plannedDepartureTime,
    this.actualDepartureTime,
    required this.status,
    this.notes,
    required this.createdAt,
  });

  factory TripWaypoint.fromJson(Map<String, dynamic> json) {
    return TripWaypoint(
      id: json['id'] as int,
      tripId: json['tripId'] as int,
      sequenceNumber: json['sequenceNumber'] as int,
      waypointName: json['waypointName'] as String,
      address: json['address'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      plannedArrivalTime: json['plannedArrivalTime'] != null
          ? DateTime.parse(json['plannedArrivalTime'] as String)
          : null,
      actualArrivalTime: json['actualArrivalTime'] != null
          ? DateTime.parse(json['actualArrivalTime'] as String)
          : null,
      plannedDepartureTime: json['plannedDepartureTime'] != null
          ? DateTime.parse(json['plannedDepartureTime'] as String)
          : null,
      actualDepartureTime: json['actualDepartureTime'] != null
          ? DateTime.parse(json['actualDepartureTime'] as String)
          : null,
      status: json['status'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripId': tripId,
      'sequenceNumber': sequenceNumber,
      'waypointName': waypointName,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'plannedArrivalTime': plannedArrivalTime?.toIso8601String(),
      'actualArrivalTime': actualArrivalTime?.toIso8601String(),
      'plannedDepartureTime': plannedDepartureTime?.toIso8601String(),
      'actualDepartureTime': actualDepartureTime?.toIso8601String(),
      'status': status,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}