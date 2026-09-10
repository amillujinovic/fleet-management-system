import 'package:fleet_management_app/models/obd_readings.dart';
import '../../models/obd_readings.dart';
abstract class ObdState {}
class ObdInitial extends ObdState{}
class ObdLoading extends ObdState{}
class ObdLoaded extends ObdState{
  final List<ObdReading> readings;
  final List<String> trendWarnings;
  final ObdReading? latest;
  ObdLoaded({required this.readings, this.latest,this.trendWarnings = const [],});
  

}
class ObdError extends ObdState
{
  final String message;
  ObdError(this.message);
}