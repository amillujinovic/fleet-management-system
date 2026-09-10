import '../models/vehicle.dart';
import 'api_client.dart';
class VehicleService
{
  Future<List<Vehicle>> getAllVehicles() async {
    final response = await ApiClient.get('Vehicles');
    final List<dynamic> data = ApiClient.parseResponse(response);
    return data.map((json) => Vehicle.fromJson(json)).toList();
  }
  Future<Vehicle> getVehicleById(int id) async
  {
    final response=await ApiClient.get('Vehicles/$id');
    final data=ApiClient.parseResponse(response);
    return Vehicle.fromJson(data);
  }
  Future<Vehicle> createVehicle(Vehicle vehicle) async
  {
    final response=await ApiClient.post('Vehicles',vehicle.toJson());
    final data=ApiClient.parseResponse(response);
    return data != null ? Vehicle.fromJson(data) : vehicle;
  }
  Future<Vehicle> updateVehicle(int id,Vehicle vehicle) async
  {
    final response= await ApiClient.put('Vehicles/$id',vehicle.toJson());
    ApiClient.parseResponse(response);
    return vehicle;
  }
  Future<void> deleteVehicle(int id) async
  {
    final response=await ApiClient.delete('Vehicles/$id');
    ApiClient.parseResponse(response);
  }
  
}