class FuelRecord {
  final int id;
  final int vehicleId;
  final String? driverId;
  final int? tripId;
  final String fuelType;
  final double quantity;
  final double unitPrice;
  final double totalCost;
  final String currency;
  final int? odometerReading;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? fuelStationName;
  final String? receiptNumber;
  final DateTime filledAt;
  final DateTime createdAt;

  FuelRecord({
    required this.id,
    required this.vehicleId,
    this.driverId,
    this.tripId,
    required this.fuelType,
    required this.quantity,
    required this.unitPrice,
    required this.totalCost,
    required this.currency,
    this.odometerReading,
    this.location,
    this.latitude,
    this.longitude,
    this.fuelStationName,
    this.receiptNumber,
    required this.filledAt,
    required this.createdAt,
  });

  factory FuelRecord.fromJson(Map<String, dynamic> json) {
    return FuelRecord(
      id: json['id'] as int,
      vehicleId: json['vehicleId'] as int,
      driverId: json['driverId'] as String?,
      tripId: json['tripId'] as int?,
      fuelType: json['fuelType'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      totalCost: (json['totalCost'] as num).toDouble(),
      currency: json['currency'] as String,
      odometerReading: json['odometerReading'] as int?,
      location: json['location'] as String?,
      latitude: json['latitude'] != null 
          ? (json['latitude'] as num).toDouble() 
          : null,
      longitude: json['longitude'] != null 
          ? (json['longitude'] as num).toDouble() 
          : null,
      fuelStationName: json['fuelStationName'] as String?,
      receiptNumber: json['receiptNumber'] as String?,
      filledAt: DateTime.parse(json['filledAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'driverId': driverId,
      'tripId': tripId,
      'fuelType': fuelType,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalCost': totalCost,
      'currency': currency,
      'odometerReading': odometerReading,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'fuelStationName': fuelStationName,
      'receiptNumber': receiptNumber,
      'filledAt': filledAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}