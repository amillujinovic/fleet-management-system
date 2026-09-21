import 'package:equatable/equatable.dart';
import 'package:fleet_management_app/models/alert.dart';

abstract class AlertState extends Equatable {
  const AlertState();

  @override
  List<Object> get props => [];
}
class AlertInitial extends AlertState {}
class AlertLoading extends AlertState {}
class AlertLoaded extends AlertState {
  final List<Alert> alerts;

  const AlertLoaded(this.alerts);

  @override
  List<Object> get props => [alerts];
}
class AlertDetailsLoaded extends AlertState {
  final Alert alert;

  const AlertDetailsLoaded(this.alert);

  @override
  List<Object> get props => [alert];
}
class UnreadAlertsLoaded extends AlertState {
  final List<Alert> alerts;

  const UnreadAlertsLoaded(this.alerts);

  @override
  List<Object> get props => [alerts];
}
class AlertByVehicleLoaded extends AlertState {
  final List<Alert> alerts;

  const AlertByVehicleLoaded(this.alerts);

  @override
  List<Object> get props => [alerts];
}
class AlertError extends AlertState {
  final String message;

  const AlertError(this.message);

  @override
  List<Object> get props => [message];
}
class AlertMarkedAsRead extends AlertState {
  final String alertId;

  const AlertMarkedAsRead(this.alertId);

  @override
  List<Object> get props => [alertId];
}

class AlertDismissed extends AlertState {  
  final int alertId;

  const AlertDismissed(this.alertId);

  @override
  List<Object> get props => [alertId];
}
class AllAlertsMarkedAsRead extends AlertState {}
class AlertsRefreshed extends AlertState {}