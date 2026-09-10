import 'package:fleet_management_app/models/obd_readings.dart';

import '../services/api_client.dart';
import '../models/obd_readings.dart';

class ObdService {
  static Future<List<ObdReading>> getForVehicle(int vehicleId) async {
    final response = await ApiClient.get('Obd/Vehicle/$vehicleId');
    final data = ApiClient.parseResponse(response);
    return (data as List).map((e) => ObdReading.fromJson(e)).toList();
  }

  static Future<ObdReading> simulateAnomaly(int vehicleId) async {
  final i = DateTime.now().millisecondsSinceEpoch % 10;
  final body = {
    'vehicleId':  vehicleId,
    'rpm':        5800 + (i * 80).toInt(),
    'speed':      15.0 + i,
    'engineTemp': 88.0 + (i * 3),   // raste 88→115
    'engineLoad': 60.0 + (i * 4),   // raste 60→96
    'fuelLevel':  25.0 - (i * 2),   // pada 25→5
  };
  final response = await ApiClient.post('Obd/Track', body);
  final data = ApiClient.parseResponse(response);
  return ObdReading.fromJson(data);
}
static Future<List<String>> getTrendWarnings(int vehicleId) async {
  try {
    final response = await ApiClient.get('Obd/Vehicle/$vehicleId/Trend');
    final data = ApiClient.parseResponse(response);
    print('TREND DATA: $data');           
    print('TREND TYPE: ${data.runtimeType}');
    final warnings = (data['warnings'] as List<dynamic>?) ?? [];
    return warnings.map((w) => w.toString()).toList();
  } catch (e) {
     print('Trend error: $e');
    return [];
  }
}
}