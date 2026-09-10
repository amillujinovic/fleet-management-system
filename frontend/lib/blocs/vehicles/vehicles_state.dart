import 'package:equatable/equatable.dart';
import 'package:fleet_management_app/models/vehicle.dart';

abstract class VehicleState extends Equatable {
  const VehicleState();

  @override
  List<Object?> get props => [];
}
class VehicleInitial extends VehicleState {}
class VehicleLoading extends VehicleState {}
class VehicleLoaded extends VehicleState
{
  final List<Vehicle> vehicles;
  const VehicleLoaded({required this.vehicles});
  @override
  List<Object?> get props => [vehicles];
}
class VehicleDetailsLoaded extends VehicleState
{
  final Vehicle vehicle;
  const VehicleDetailsLoaded({required this.vehicle});
  @override
  List<Object?> get props => [vehicle];
}
class VehicleError extends VehicleState
{
  final String message;
  const VehicleError({required this.message});
  @override
  List<Object?> get props => [message];
}
class VehicleCreated extends VehicleState
{
  final Vehicle vehicle;
  const VehicleCreated({required this.vehicle});
  @override
  List<Object?> get props => [vehicle];
}
class VehicleUpdated extends VehicleState
{
  final Vehicle vehicle;
  const VehicleUpdated({required this.vehicle});
  @override
  List<Object?> get props => [vehicle];
}
class VehicleDeleted extends VehicleState
{
  final int vehicleId;
  const VehicleDeleted({required this.vehicleId});
  @override
  List<Object?> get props => [vehicleId];
}