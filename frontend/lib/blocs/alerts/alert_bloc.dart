import 'package:fleet_management_app/blocs/alerts/alert_event.dart';
import 'package:fleet_management_app/blocs/alerts/alert_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AlertsBloc extends Bloc<AlertEvent, AlertState> {
  // final ApiService apiService;

  AlertsBloc() : super(AlertInitial()) {
    on<LoadAlerts>(_onLoadAlerts);
    on<LoadAlertDetails>(_onLoadAlertDetails);
    on<LoadUnreadAlerts>(_onLoadUnreadAlerts);
    on<LoadAlertByVehicle>(_onLoadAlertsByVehicle);
    on<FilterAlertsBySeverity>(_onFilterAlertsBySeverity);
    on<MarkAlertAsRead>(_onMarkAlertAsRead);
    on<DeleteAlert>(_onDismissAlert);
    on<MarkAllAlertsAsRead>(_onMarkAllAlertsAsRead);
    on<RefreshAlerts>(_onRefreshAlerts);
  }

  Future<void> _onLoadAlerts(
    LoadAlerts event,
    Emitter<AlertState> emit,
  ) async {
    emit(AlertLoading());

    try {
      // TODO: final alerts = await apiService.getAlerts();
      await Future.delayed(Duration(seconds: 1));
      emit(AlertError('API service not implemented yet'));
    } catch (e) {
      emit(AlertError(e.toString()));
    }
  }

  Future<void> _onLoadAlertDetails(
    LoadAlertDetails event,
    Emitter<AlertState> emit,
  ) async {
    emit(AlertLoading());

    try {
      // TODO: final alert = await apiService.getAlertById(event.alertId);
      await Future.delayed(Duration(seconds: 1));
      emit(AlertError('API service not implemented yet'));
    } catch (e) {
      emit(AlertError(e.toString()));
    }
  }

  Future<void> _onLoadUnreadAlerts(
    LoadUnreadAlerts event,
    Emitter<AlertState> emit,
  ) async {
    emit(AlertLoading());

    try {
      // TODO: final alerts = await apiService.getUnreadAlerts();
      await Future.delayed(Duration(seconds: 1));
      emit(AlertError('API service not implemented yet'));
    } catch (e) {
      emit(AlertError(e.toString()));
    }
  }

  Future<void> _onLoadAlertsByVehicle(
    LoadAlertByVehicle event,
    Emitter<AlertState> emit,
  ) async {
    emit(AlertLoading());

    try {
      // TODO: final alerts = await apiService.getAlertsByVehicle(event.vehicleId);
      await Future.delayed(Duration(seconds: 1));
      emit(AlertError('API service not implemented yet'));
    } catch (e) {
      emit(AlertError(e.toString()));
    }
  }

  Future<void> _onFilterAlertsBySeverity(
    FilterAlertsBySeverity event,
    Emitter<AlertState> emit,
  ) async {
    emit(AlertLoading());

    try {
      // TODO: final alerts = await apiService.getAlertsBySeverity(event.severity);
      await Future.delayed(Duration(seconds: 1));
      emit(AlertError('API service not implemented yet'));
    } catch (e) {
      emit(AlertError(e.toString()));
    }
  }

  Future<void> _onMarkAlertAsRead(
    MarkAlertAsRead event,
    Emitter<AlertState> emit,
  ) async {
    emit(AlertLoading());

    try {
      // TODO: await apiService.markAlertAsRead(event.alertId);
      await Future.delayed(Duration(seconds: 1));
      emit(AlertError('Mark as read not implemented yet'));
    } catch (e) {
      emit(AlertError(e.toString()));
    }
  }

  Future<void> _onDismissAlert(
  DeleteAlert event,  // ✅ Koristi DeleteAlert EVENT
  Emitter<AlertState> emit,
) async {
  emit(AlertLoading());

  try {
    // TODO: await apiService.deleteAlert(event.alertId);
    await Future.delayed(Duration(seconds: 1));
    emit(AlertDismissed(event.alertId as int));  
  } catch (e) {
    emit(AlertError(e.toString()));
  }
}

  Future<void> _onMarkAllAlertsAsRead(
    MarkAllAlertsAsRead event,
    Emitter<AlertState> emit,
  ) async {
    emit(AlertLoading());

    try {
      // TODO: await apiService.markAllAlertsAsRead();
      await Future.delayed(Duration(seconds: 1));
      emit(AlertError('Mark all as read not implemented yet'));
    } catch (e) {
      emit(AlertError(e.toString()));
    }
  }

  Future<void> _onRefreshAlerts(
    RefreshAlerts event,
    Emitter<AlertState> emit,
  ) async {
    add(LoadAlerts());
  }
}