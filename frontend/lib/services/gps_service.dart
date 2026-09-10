import 'api_client.dart';
class GpsPoint
{
  final double latitude;
  final double longitude;
  final double? speed;
  final DateTime? recordedAt;
  GpsPoint
  ({
    required this.latitude,
    required this.longitude,
    this.speed,
    this.recordedAt,
  });
  factory GpsPoint.fromJson(Map<String,dynamic> json)
  {
    double toDouble(dynamic v) =>
        v == null ? 0.0 : (v is num ? v.toDouble() : double.tryParse('$v') ?? 0.0);
    final lat = json['latitude'] ?? json['lat'];
    final lng = json['longitude'] ?? json['lng'] ?? json['lon'];
    final spd = json['speed'];
    final ts = json['recordedAt'] ?? json['timestamp'] ?? json['createdAt'];
    return GpsPoint(latitude: toDouble(lat), longitude: toDouble(lng),speed: spd == null ? null : toDouble(spd),
      recordedAt: ts == null ? null : DateTime.tryParse('$ts'));

  }
}
class GpsService {
  Future<GpsPoint?> getLatestForVehicle(int vehicleId) async {
    final response= await ApiClient.get('Gps/Vehicle/$vehicleId/Latest');
    final data=ApiClient.parseResponse(response);
    if (data == null) return null;
    return GpsPoint.fromJson(data);
  }
  Future<List<GpsPoint>> getHistory(int vehicleId, {int maxResults = 100}) async
  {
    final now=DateTime.now();
    final body = {
    'vehicleId': vehicleId,
    // širok raspon (jučer -> sutra) da uhvati sve tačke
    'startDate': now.subtract(const Duration(days: 1)).toIso8601String(),
    'endDate': now.add(const Duration(days: 1)).toIso8601String(),
    'maxResults': maxResults,
   };
  final response= await ApiClient.post('Gps/Vehicle/History', body);
  final data = ApiClient.parseResponse(response);
  if (data == null) return [];
  final list=data as List;
  final points=list.map((j) => GpsPoint.fromJson(j as Map<String, dynamic>)).toList();
  points.sort((a, b) {
    final ta = a.recordedAt ?? DateTime(2000);
    final tb = b.recordedAt ?? DateTime(2000);
    return ta.compareTo(tb);
  });

  return points;
  }
}

