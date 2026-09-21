class ObdReading {
  final int id;
  final int vehicleId;
  final int? rpm;
  final double? speed;
  final double? engineTemp;
  final double? engineLoad;
  final double? fuelLevel;
  final double? anomalyScore;
  final bool? isAnomaly;
  final DateTime recordedAt;

  ObdReading({
    required this.id,
    required this.vehicleId,
    this.rpm,
    this.speed,
    this.engineTemp,
    this.engineLoad,
    this.fuelLevel,
    this.anomalyScore,
    this.isAnomaly,
    required this.recordedAt,
  });

  factory ObdReading.fromJson(Map<String, dynamic> json) {
    return ObdReading(
      id:           json['id'],
      vehicleId:    json['vehicleId'],
      rpm:          json['rpm'],
      speed:        json['speed']?.toDouble(),
      engineTemp:   json['engineTemp']?.toDouble(),
      engineLoad:   json['engineLoad']?.toDouble(),
      fuelLevel:    json['fuelLevel']?.toDouble(),
      anomalyScore: json['anomalyScore']?.toDouble(),
      isAnomaly:    json['isAnomaly'],
      recordedAt:   DateTime.parse(json['recordedAt']),
    );
  }
}