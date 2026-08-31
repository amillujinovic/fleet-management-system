abstract class ObdEvent{}
class LoadObdReadings extends ObdEvent
{
  final int vehicleId;
  LoadObdReadings({required this.vehicleId});
}
class SimulateAnomaly extends ObdEvent
{
  final int vehicleId;
  SimulateAnomaly( {required this.vehicleId});
}