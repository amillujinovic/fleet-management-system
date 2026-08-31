import 'package:equatable/equatable.dart';
import 'package:fleet_management_app/models/trip.dart';

abstract class TripsEvent extends Equatable
{
  const TripsEvent();
  @override
  List<Object?> get props => [];
}
class LoadTrips extends TripsEvent
{
}
class LoadTripDetails extends TripsEvent
{
  final int tripId;
  const LoadTripDetails(this.tripId);
  @override
  List<Object?> get props => [tripId];
}
class LoadTripsByVehicle extends TripsEvent
{
  final int vehicleId;
  const LoadTripsByVehicle(this.vehicleId);
  @override
  List<Object?> get props => [vehicleId];
}
class LoadActiveTrips extends TripsEvent
{
}
class CreateTrip extends TripsEvent
{
  final Trip trip;
  const CreateTrip(this.trip);
  @override
  List<Object?> get props => [trip];
}
class UpdateTrip extends TripsEvent
{
  final Trip trip;
  const UpdateTrip(this.trip);
  @override
  List<Object?> get props => [trip];
}
class DeleteTrip extends TripsEvent
{
  final int tripId;
  const DeleteTrip(this.tripId);
  @override
  List<Object?> get props => [tripId];
}
class StartTrip extends TripsEvent
{
  final int tripId;
  const StartTrip(this.tripId);
  @override
  List<Object?> get props => [tripId];
}
class EndTrip extends TripsEvent
{
  final int tripId;
  const EndTrip(this.tripId);
  @override
  List<Object?> get props => [tripId];
}
class CancelTrip extends TripsEvent
{
  final int tripId;
  const CancelTrip(this.tripId);
  @override
  List<Object?> get props => [tripId];
}
class RefreshTrips extends TripsEvent
{
}