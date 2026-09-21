class Alert {
  final int id;
  final int? vehicleId;              
  final String? driverId;            
  final int? tripId;                 
  final int? geofenceId;             
  final String alertType;
  final String severity;
  final String? title;              
  final String message;
  final double? latitude;          
  final double? longitude;           
  final String? metaData;            
  final String status;
  final String? acknowledgedBy;      
  final DateTime? acknowledgedAt;    
  final DateTime createdAt;
  final DateTime? updatedAt;         

  Alert({
    required this.id,
    this.vehicleId,                  
    this.driverId,
    this.tripId,
    this.geofenceId,
    required this.alertType,
    required this.severity,
    this.title,
    required this.message,
    this.latitude,
    this.longitude,
    this.metaData,
    required this.status,
    this.acknowledgedBy,
    this.acknowledgedAt,
    required this.createdAt,
    this.updatedAt,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      id: json['id'] as int,
      vehicleId: json['vehicleId'] as int?,
      driverId: json['driverId'] as String?,
      tripId: json['tripId'] as int?,
      geofenceId: json['geofenceId'] as int?,
      alertType: json['alertType'] as String,
      severity: json['severity'] as String,
      title: json['title'] as String?,
      message: json['message'] as String,
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
      metaData: json['metaData'] as String?,
      status: json['status'] as String,
      acknowledgedBy: json['acknowledgedBy'] as String?,
      acknowledgedAt: json['acknowledgedAt'] != null 
          ? DateTime.parse(json['acknowledgedAt'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'driverId': driverId,
      'tripId': tripId,
      'geofenceId': geofenceId,
      'alertType': alertType,
      'severity': severity,
      'title': title,
      'message': message,
      'latitude': latitude,
      'longitude': longitude,
      'metaData': metaData,
      'status': status,
      'acknowledgedBy': acknowledgedBy,
      'acknowledgedAt': acknowledgedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}