import 'package:equatable/equatable.dart';
import 'package:fleet_management_app/models/trip.dart';

abstract class TripState extends Equatable
{
  const TripState();
  @override
  List<Object?> get props => [];
}
class TripInitial extends TripState
{
}
class TripLoading extends TripState
{
}
class TripLoaded extends TripState
{
  final List<Trip> trips;
  const TripLoaded(this.trips);
  @override
  List<Object?> get props => [trips];
}
class TripDetailsLoaded extends TripState
{
  final Trip trip;
  const TripDetailsLoaded(this.trip);
  @override
  List<Object?> get props => [trip];
}
class ActiveTripsLoaded extends TripState
{
  final List<Trip> trips;
  const ActiveTripsLoaded(this.trips);
  @override
  List<Object?> get props => [trips];
}
class TripsByVehicleLoaded extends TripState
{
  final List<Trip> trips;
  const TripsByVehicleLoaded(this.trips);
  @override
  List<Object?> get props => [trips];
}
class TripsError extends TripState
{
  final String message;
  const TripsError(this.message);
  @override
  List<Object?> get props => [message];
}
class TripCreated extends TripState
{
  final String message;
  const TripCreated(this.message);
  @override
  List<Object?> get props => [message];
}
class TripUpdated extends TripState
{
  final String message;
  const TripUpdated(this.message);
  @override
  List<Object?> get props => [message];
}
class TripDeleted extends TripState
{
  final String message;
  const TripDeleted(this.message);
  @override
  List<Object?> get props => [message];
}
class TripStarted extends TripState
{
  final String message;
  const TripStarted(this.message);
  @override
  List<Object?> get props => [message];
}
class TripEnded extends TripState
{
  final String message;
  const TripEnded(this.message);
  @override
  List<Object?> get props => [message];
}
class TripCanceled extends TripState
{
  final String message;
  const TripCanceled(this.message);
  @override
  List<Object?> get props => [message];
}