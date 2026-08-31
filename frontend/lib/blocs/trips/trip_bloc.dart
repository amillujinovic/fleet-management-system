import 'package:fleet_management_app/blocs/trips/trip_event.dart';
import 'package:fleet_management_app/blocs/trips/trip_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripBloc extends Bloc<TripsEvent, TripState>
{
  TripBloc() : super(TripInitial())
  {
    on<LoadTrips>(_onLoadTrips);
    on<LoadTripDetails>(_onLoadTripDetails);
    on<LoadTripsByVehicle>(_onLoadTripsByVehicle);
    on<LoadActiveTrips>(_onLoadActiveTrips);
    on<CreateTrip>(_onCreateTrip);
    on<UpdateTrip>(_onUpdateTrip);
    on<DeleteTrip>(_onDeleteTrip);
    on<StartTrip>(_onStartTrip);
    on<EndTrip>(_onEndTrip);
    on<CancelTrip>(_onCancelTrip);
  }
  Future<void> _onLoadTrips(TripsEvent event, Emitter<TripState> emit) async
  {
    emit(TripLoading());
     try {
      // TODO: final trips = await apiService.getTrips();
      await Future.delayed(Duration(seconds: 1)); // Simulacija
      emit(TripsError('API service not implemented yet'));
    } catch (e) {
      emit(TripsError(e.toString()));
    }
  }
  Future<void> _onLoadTripDetails(LoadTripDetails event, Emitter<TripState> emit) async
  {
    emit(TripLoading());
     try {
      // TODO: final trips = await apiService.getTrips();
      await Future.delayed(Duration(seconds: 1)); // Simulacija
      emit(TripsError('API service not implemented yet'));
    } catch (e) {
      emit(TripsError(e.toString()));
    }
  }
  Future<void> _onLoadTripsByVehicle(LoadTripsByVehicle event, Emitter<TripState> emit) async
  {
    emit(TripLoading());
     try {
      // TODO: final trips = await apiService.getTrips();
      await Future.delayed(Duration(seconds: 1)); // Simulacija
      emit(TripsError('API service not implemented yet'));
    } catch (e) {
      emit(TripsError(e.toString()));
    }
  }
  Future<void> _onLoadActiveTrips(LoadActiveTrips event, Emitter<TripState> emit) async
  {
    emit(TripLoading());
    try {
      // TODO: final trips = await apiService.getTrips();
      await Future.delayed(Duration(seconds: 1)); // Simulacija
      emit(TripsError('API service not implemented yet'));
    } catch (e) {
      emit(TripsError(e.toString()));
    }
  }
  Future<void> _onCreateTrip(CreateTrip event, Emitter<TripState> emit) async
  {
    emit(TripLoading());
     try {
      // TODO: final trips = await apiService.getTrips();
      await Future.delayed(Duration(seconds: 1)); // Simulacija
      emit(TripsError('API service not implemented yet'));
    } catch (e) {
      emit(TripsError(e.toString()));
    }
  }
  Future<void> _onUpdateTrip(UpdateTrip event, Emitter<TripState> emit) async
  {
    emit(TripLoading());
     try {
      // TODO: final trips = await apiService.getTrips();
      await Future.delayed(Duration(seconds: 1)); // Simulacija
      emit(TripsError('API service not implemented yet'));
    } catch (e) {
      emit(TripsError(e.toString()));
    }
  }
  Future<void> _onDeleteTrip(DeleteTrip event, Emitter<TripState> emit) async
  {
    emit(TripLoading());
     try {
      // TODO: final trips = await apiService.getTrips();
      await Future.delayed(Duration(seconds: 1)); // Simulacija
      emit(TripsError('API service not implemented yet'));
    } catch (e) {
      emit(TripsError(e.toString()));
    }
  }
  Future<void> _onStartTrip(StartTrip event, Emitter<TripState> emit) async
  {
    emit(TripLoading());
     try {
      // TODO: final trips = await apiService.getTrips();
      await Future.delayed(Duration(seconds: 1)); // Simulacija
      emit(TripsError('API service not implemented yet'));
    } catch (e) {
      emit(TripsError(e.toString()));
    }
  }
  Future<void> _onEndTrip(EndTrip event, Emitter<TripState> emit) async
  {
    emit(TripLoading());
     try {
      // TODO: final trips = await apiService.getTrips();
      await Future.delayed(Duration(seconds: 1)); // Simulacija
      emit(TripsError('API service not implemented yet'));
    } catch (e) {
      emit(TripsError(e.toString()));
    }
  }
  Future<void> _onCancelTrip(CancelTrip event, Emitter<TripState> emit) async
  {
    emit(TripLoading());
     try {
      // TODO: final trips = await apiService.getTrips();
      await Future.delayed(Duration(seconds: 1)); // Simulacija
      emit(TripsError('API service not implemented yet'));
    } catch (e) {
      emit(TripsError(e.toString()));
    }
  }
  Future<void> refreshTrips() async
  {
    add(LoadTrips());
  }
}