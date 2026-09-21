import 'package:equatable/equatable.dart';
import '../../models/maintenance_record.dart';

abstract class MaintenanceEvent extends Equatable {
  const MaintenanceEvent();

  @override
  List<Object?> get props => [];
}


class LoadMaintenanceRecords extends MaintenanceEvent {}

class LoadMaintenanceDetails extends MaintenanceEvent {
  final int maintenanceId;

  const LoadMaintenanceDetails(this.maintenanceId);

  @override
  List<Object?> get props => [maintenanceId];
}

class LoadMaintenanceByVehicle extends MaintenanceEvent {
  final int vehicleId;

  const LoadMaintenanceByVehicle(this.vehicleId);

  @override
  List<Object?> get props => [vehicleId];
}

class LoadUpcomingMaintenance extends MaintenanceEvent {}

class FilterMaintenanceByStatus extends MaintenanceEvent {
  final String status;

  const FilterMaintenanceByStatus(this.status);

  @override
  List<Object?> get props => [status];
}

class CreateMaintenanceRecord extends MaintenanceEvent {
  final MaintenanceRecord record;

  const CreateMaintenanceRecord(this.record);

  @override
  List<Object?> get props => [record];
}

// Ažuriraj maintenance record
class UpdateMaintenanceRecord extends MaintenanceEvent {
  final MaintenanceRecord record;

  const UpdateMaintenanceRecord(this.record);

  @override
  List<Object?> get props => [record];
}

// Obriši maintenance record
class DeleteMaintenanceRecord extends MaintenanceEvent {
  final int maintenanceId;

  const DeleteMaintenanceRecord(this.maintenanceId);

  @override
  List<Object?> get props => [maintenanceId];
}

// Označi kao completed
class CompleteMaintenanceRecord extends MaintenanceEvent {
  final int maintenanceId;

  const CompleteMaintenanceRecord(this.maintenanceId);

  @override
  List<Object?> get props => [maintenanceId];
}

// Refresh
class RefreshMaintenanceRecords extends MaintenanceEvent {}