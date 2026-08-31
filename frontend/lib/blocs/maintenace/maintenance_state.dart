import 'package:equatable/equatable.dart';
import '../../models/maintenance_record.dart';

abstract class MaintenanceState extends Equatable {
  const MaintenanceState();

  @override
  List<Object?> get props => [];
}

// Početno stanje
class MaintenanceInitial extends MaintenanceState {}

// Učitavanje
class MaintenanceLoading extends MaintenanceState {}

// Lista maintenance records učitana
class MaintenanceRecordsLoaded extends MaintenanceState {
  final List<MaintenanceRecord> records;

  const MaintenanceRecordsLoaded(this.records);

  @override
  List<Object?> get props => [records];
}

// Detalji jednog record-a
class MaintenanceDetailsLoaded extends MaintenanceState {
  final MaintenanceRecord record;

  const MaintenanceDetailsLoaded(this.record);

  @override
  List<Object?> get props => [record];
}

// Maintenance za vozilo učitan
class MaintenanceByVehicleLoaded extends MaintenanceState {
  final List<MaintenanceRecord> records;
  final int vehicleId;

  const MaintenanceByVehicleLoaded(this.records, this.vehicleId);

  @override
  List<Object?> get props => [records, vehicleId];
}

// Upcoming maintenance učitan
class UpcomingMaintenanceLoaded extends MaintenanceState {
  final List<MaintenanceRecord> records;

  const UpcomingMaintenanceLoaded(this.records);

  @override
  List<Object?> get props => [records];
}

// Greška
class MaintenanceError extends MaintenanceState {
  final String message;

  const MaintenanceError(this.message);

  @override
  List<Object?> get props => [message];
}

// Record kreiran
class MaintenanceRecordCreated extends MaintenanceState {
  final MaintenanceRecord record;

  const MaintenanceRecordCreated(this.record);

  @override
  List<Object?> get props => [record];
}

// Record ažuriran
class MaintenanceRecordUpdated extends MaintenanceState {
  final MaintenanceRecord record;

  const MaintenanceRecordUpdated(this.record);

  @override
  List<Object?> get props => [record];
}

// Record obrisan
class MaintenanceRecordDeleted extends MaintenanceState {
  final int maintenanceId;

  const MaintenanceRecordDeleted(this.maintenanceId);

  @override
  List<Object?> get props => [maintenanceId];
}

// Record completed
class MaintenanceRecordCompleted extends MaintenanceState {
  final MaintenanceRecord record;

  const MaintenanceRecordCompleted(this.record);

  @override
  List<Object?> get props => [record];
}