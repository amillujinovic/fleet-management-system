import 'package:equatable/equatable.dart';

abstract class AlertEvent extends Equatable {
  const AlertEvent();

  @override
  List<Object> get props => [];
}
class LoadAlerts extends AlertEvent {
  
}
class LoadAlertDetails extends AlertEvent {
  final String alertId;

  const LoadAlertDetails(this.alertId);

  @override
  List<Object> get props => [alertId];
}
class LoadUnreadAlerts extends AlertEvent {
  
}
class LoadAlertByVehicle extends AlertEvent {
  final String vehicleId;

  const LoadAlertByVehicle(this.vehicleId);

  @override
  List<Object> get props => [vehicleId];
}
class FilterAlertsBySeverity extends AlertEvent
{
  final String severity;

  const FilterAlertsBySeverity(this.severity);

  @override
  List<Object> get props => [severity];
}
class MarkAlertAsRead extends AlertEvent {
  final String alertId;

  const MarkAlertAsRead(this.alertId);

  @override
  List<Object> get props => [alertId];
}
class DeleteAlert extends AlertEvent {
  final String alertId;

  const DeleteAlert(this.alertId);

  @override
  List<Object> get props => [alertId];
}

class MarkAllAlertsAsRead extends AlertEvent {
  
}
class RefreshAlerts extends AlertEvent { 
}
