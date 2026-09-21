import 'package:fleet_management_app/models/obd_readings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/obd_readings.dart';
import '../../services/obd_service.dart';
import 'obd_event.dart';
import 'obd_state.dart';

class ObdBloc extends Bloc<ObdEvent, ObdState> {
  ObdBloc() : super(ObdInitial()) {
    on<LoadObdReadings>(_onLoad);
    on<SimulateAnomaly>(_onSimulate);
  }

  Future<void> _onLoad(
    LoadObdReadings event,
    Emitter<ObdState> emit,
  ) async {
    emit(ObdLoading());
    try {
      final readings = await ObdService.getForVehicle(event.vehicleId);
      final latest = readings.isNotEmpty ? readings.last : null;
      final trendWarnings = await ObdService.getTrendWarnings(event.vehicleId);
      emit(ObdLoaded(readings: readings, latest: latest, trendWarnings: trendWarnings,));
    } catch (e) {
      emit(ObdError(e.toString()));
    }
  }

  Future<void> _onSimulate(
  SimulateAnomaly event,
  Emitter<ObdState> emit,
) async {
  final current = state is ObdLoaded
      ? (state as ObdLoaded).readings
      : <ObdReading>[];

  emit(ObdLoading());
  try {
    final reading = await ObdService.simulateAnomaly(event.vehicleId);
    // Osvježi trend nakon simulate
    final trendWarnings = await ObdService.getTrendWarnings(event.vehicleId);
    emit(ObdLoaded(
      readings: [...current, reading],
      latest: reading,
      trendWarnings: trendWarnings, 
    ));
  } catch (e) {
    emit(ObdError(e.toString()));
  }
}
}