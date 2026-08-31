import 'package:flutter_bloc/flutter_bloc.dart';
import 'maintenance_event.dart';
import 'maintenance_state.dart';
// import '../../services/api_service.dart';

class MaintenanceBloc extends Bloc<MaintenanceEvent, MaintenanceState> {
  // final ApiService apiService;

  MaintenanceBloc() : super(MaintenanceInitial()) {
    on<LoadMaintenanceRecords>(_onLoadMaintenanceRecords);
    on<LoadMaintenanceDetails>(_onLoadMaintenanceDetails);
    on<LoadMaintenanceByVehicle>(_onLoadMaintenanceByVehicle);
    on<LoadUpcomingMaintenance>(_onLoadUpcomingMaintenance);
    on<FilterMaintenanceByStatus>(_onFilterMaintenanceByStatus);
    on<CreateMaintenanceRecord>(_onCreateMaintenanceRecord);
    on<UpdateMaintenanceRecord>(_onUpdateMaintenanceRecord);
    on<DeleteMaintenanceRecord>(_onDeleteMaintenanceRecord);
    on<CompleteMaintenanceRecord>(_onCompleteMaintenanceRecord);
    on<RefreshMaintenanceRecords>(_onRefreshMaintenanceRecords);
  }

  Future<void> _onLoadMaintenanceRecords(
    LoadMaintenanceRecords event,
    Emitter<MaintenanceState> emit,
  ) async {
    emit(MaintenanceLoading());

    try {
      // TODO: final records = await apiService.getMaintenanceRecords();
      await Future.delayed(Duration(seconds: 1));
      emit(MaintenanceError('API service not implemented yet'));
    } catch (e) {
      emit(MaintenanceError(e.toString()));
    }
  }

  Future<void> _onLoadMaintenanceDetails(
    LoadMaintenanceDetails event,
    Emitter<MaintenanceState> emit,
  ) async {
    emit(MaintenanceLoading());

    try {
      // TODO: final record = await apiService.getMaintenanceById(event.maintenanceId);
      await Future.delayed(Duration(seconds: 1));
      emit(MaintenanceError('API service not implemented yet'));
    } catch (e) {
      emit(MaintenanceError(e.toString()));
    }
  }

  Future<void> _onLoadMaintenanceByVehicle(
    LoadMaintenanceByVehicle event,
    Emitter<MaintenanceState> emit,
  ) async {
    emit(MaintenanceLoading());

    try {
      // TODO: final records = await apiService.getMaintenanceByVehicle(event.vehicleId);
      await Future.delayed(Duration(seconds: 1));
      emit(MaintenanceError('API service not implemented yet'));
    } catch (e) {
      emit(MaintenanceError(e.toString()));
    }
  }

  Future<void> _onLoadUpcomingMaintenance(
    LoadUpcomingMaintenance event,
    Emitter<MaintenanceState> emit,
  ) async {
    emit(MaintenanceLoading());

    try {
      // TODO: final records = await apiService.getUpcomingMaintenance();
      await Future.delayed(Duration(seconds: 1));
      emit(MaintenanceError('API service not implemented yet'));
    } catch (e) {
      emit(MaintenanceError(e.toString()));
    }
  }

  Future<void> _onFilterMaintenanceByStatus(
    FilterMaintenanceByStatus event,
    Emitter<MaintenanceState> emit,
  ) async {
    emit(MaintenanceLoading());

    try {
      // TODO: final records = await apiService.getMaintenanceByStatus(event.status);
      await Future.delayed(Duration(seconds: 1));
      emit(MaintenanceError('API service not implemented yet'));
    } catch (e) {
      emit(MaintenanceError(e.toString()));
    }
  }

  Future<void> _onCreateMaintenanceRecord(
    CreateMaintenanceRecord event,
    Emitter<MaintenanceState> emit,
  ) async {
    emit(MaintenanceLoading());

    try {
      // TODO: final record = await apiService.createMaintenanceRecord(event.record);
      await Future.delayed(Duration(seconds: 1));
      emit(MaintenanceError('Create not implemented yet'));
    } catch (e) {
      emit(MaintenanceError(e.toString()));
    }
  }

  Future<void> _onUpdateMaintenanceRecord(
    UpdateMaintenanceRecord event,
    Emitter<MaintenanceState> emit,
  ) async {
    emit(MaintenanceLoading());

    try {
      // TODO: final record = await apiService.updateMaintenanceRecord(event.record);
      await Future.delayed(Duration(seconds: 1));
      emit(MaintenanceError('Update not implemented yet'));
    } catch (e) {
      emit(MaintenanceError(e.toString()));
    }
  }

  Future<void> _onDeleteMaintenanceRecord(
    DeleteMaintenanceRecord event,
    Emitter<MaintenanceState> emit,
  ) async {
    emit(MaintenanceLoading());

    try {
      // TODO: await apiService.deleteMaintenanceRecord(event.maintenanceId);
      await Future.delayed(Duration(seconds: 1));
      emit(MaintenanceError('Delete not implemented yet'));
    } catch (e) {
      emit(MaintenanceError(e.toString()));
    }
  }

  Future<void> _onCompleteMaintenanceRecord(
    CompleteMaintenanceRecord event,
    Emitter<MaintenanceState> emit,
  ) async {
    emit(MaintenanceLoading());

    try {
      // TODO: final record = await apiService.completeMaintenanceRecord(event.maintenanceId);
      // Ili: updateMaintenanceRecord sa status = "Completed"
      await Future.delayed(Duration(seconds: 1));
      emit(MaintenanceError('Complete not implemented yet'));
    } catch (e) {
      emit(MaintenanceError(e.toString()));
    }
  }

  Future<void> _onRefreshMaintenanceRecords(
    RefreshMaintenanceRecords event,
    Emitter<MaintenanceState> emit,
  ) async {
    add(LoadMaintenanceRecords());
  }
}