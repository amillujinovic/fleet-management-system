class Geofence {
  final int id;
  final String name;
  final String? description;
  final String shapeType;
  final double? centerLatitude;
  final double? centerLongitude;
  final double? radius;
  final String? polygonCoordinates;
  final String? zoneType;
  final bool triggerOnEntry;
  final bool triggerOnExit;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Geofence({
    required this.id,
    required this.name,
    this.description,
    required this.shapeType,
    this.centerLatitude,
    this.centerLongitude,
    this.radius,
    this.polygonCoordinates,
    this.zoneType,
    required this.triggerOnEntry,
    required this.triggerOnExit,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Geofence.fromJson(Map<String,dynamic>json)
  {
    return Geofence(id: json['Id'], name: json['Name'],description: json['Description'] ,shapeType: json['ShapeType'],centerLatitude: json['CenterLatitude'],centerLongitude: json['CenterLongitude'],radius: json['Radius'],polygonCoordinates: json['PolygonCoordinates'],zoneType: json['ZoneType'] ,triggerOnEntry: json['TriggerOnEntry'], triggerOnExit: json['TriggerOnExit'], isActive: json['IsActive'], createdAt: json['CreatedAt'], updatedAt: json['UpdatedAt']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'shapeType': shapeType,
      'centerLatitude': centerLatitude,
      'centerLongitude': centerLongitude,
      'radius': radius,
      'polygonCoordinates': polygonCoordinates,
      'zoneType': zoneType,
      'triggerOnEntry': triggerOnEntry,
      'triggerOnExit': triggerOnExit,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}