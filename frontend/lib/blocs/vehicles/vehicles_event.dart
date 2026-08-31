import 'package:equatable/equatable.dart';
import 'package:fleet_management_app/models/vehicle.dart';

abstract class VehiclesEvent extends Equatable
{
  const VehiclesEvent();
  @override
  List<Object?> get props=>[];
}
class LoadVehicles extends VehiclesEvent
{
}
class LoadVehicleDetails extends VehiclesEvent
{
  final int vehicleId;
  const LoadVehicleDetails({required this.vehicleId});
  @override
  List<Object?> get props=>[vehicleId];   
}
class FilterVehiclesByStatus extends VehiclesEvent
{
final String status;
const FilterVehiclesByStatus({required this.status});
@override 
List<Object?> get props=>[status];
}
class SearchVehicles extends VehiclesEvent
{
  final String query;
  const SearchVehicles({required this.query});
  @override
  List<Object?> get props=>[query];
}
class CreateVehicle extends VehiclesEvent
{
  final Vehicle vehicle;
  const CreateVehicle({required this.vehicle});
  @override
  List<Object?> get props=>[vehicle];
}
class UpdateVehicle extends VehiclesEvent
{
  final Vehicle vehicle;
  const UpdateVehicle({required this.vehicle});
  @override
  List<Object?> get props=>[vehicle];
}
class DeleteVehicle extends VehiclesEvent
{
  final int vehicleId;
  const DeleteVehicle({required this.vehicleId});
  @override
  List<Object?> get props=>[vehicleId];
}
class RefreshVehicles extends VehiclesEvent
{ 
}