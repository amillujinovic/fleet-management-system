import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/obd/obd_bloc.dart';
import '../blocs/obd/obd_event.dart';
import '../blocs/obd/obd_state.dart';
import '../models/obd_readings.dart';
import 'dart:async';
class ObdScreen extends StatefulWidget {
  const ObdScreen({super.key});

  @override
  State<ObdScreen> createState() => _ObdScreenState();
}
class _ObdScreenState extends State<ObdScreen> {
  static const _brandBlue = Color(0xFF1A3B5D);
  final int _vehicleId = 1;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 8), (_) {
    context.read<ObdBloc>().add(LoadObdReadings(vehicleId: _vehicleId));
  });
  }
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        backgroundColor: _brandBlue,
        foregroundColor: Colors.white,
        title: const Text("OBD Monitor"),
        actions: [
          IconButton(icon: const Icon(Icons.refresh),
            onPressed: () => context
                .read<ObdBloc>()
                .add(LoadObdReadings(vehicleId: _vehicleId)),
          )
        ],
      ),
      body: BlocConsumer<ObdBloc,ObdState>(
        listener: (context, state)
        {
          if(state is ObdLoaded && state.latest?.isAnomaly==true)
          {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('⚠️ Anomaly detected!'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if(state is ObdError)
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Greška: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state){
          if(state is ObdLoading)
          {
            return const Center(child: CircularProgressIndicator());
          }
          if(state is ObdLoaded)
          {
            return _buildContent(context,state);
          }
          if (state is ObdError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text(state.message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context
                        .read<ObdBloc>()
                        .add(LoadObdReadings(vehicleId: _vehicleId)),
                    child: const Text('Try again'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }
      )
    );
  }
  Widget _buildContent(BuildContext context, ObdLoaded state)
  {
    final latest=state.latest;
    return SingleChildScrollView(
       padding: const EdgeInsets.all(16),
       child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            children: [
              _liveObdCard(latest),
              const SizedBox(height: 14,),
              if(latest!=null) _anomalyCard(latest),
              const SizedBox(height: 14,),
              if(latest!=null) _maintenanceCard(latest),
              _trendCard(state.trendWarnings),
              const SizedBox(height: 14,),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () => context
                      .read<ObdBloc>()
                      .add(SimulateAnomaly(vehicleId: _vehicleId)),
                  icon: const Icon(Icons.warning_amber),
                  label: const Text('Simulate Anomaly'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
               ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //card 1
Widget _liveObdCard(ObdReading? latest)
{
  return _card(
    title: "LIVE OBD DATA",
    child: latest==null ? const Text("No data available",style: TextStyle(color: Colors.grey))
    :Column(
      children: [
        _metricRow('RPM',
                    latest.rpm != null ? '${latest.rpm}' : '—',
                    Icons.speed),
                _metricRow(
                    'Speed',
                    latest.speed != null
                        ? '${latest.speed!.toStringAsFixed(1)} km/h'
                        : '—',
                    Icons.directions_car),
                _metricRow(
                    'Engine Temp',
                    latest.engineTemp != null
                        ? '${latest.engineTemp!.toStringAsFixed(1)}°C'
                        : '—',
                    Icons.thermostat),
                _metricRow(
                    'Engine Load',
                    latest.engineLoad != null
                        ? '${latest.engineLoad!.toStringAsFixed(1)}%'
                        : '—',
                    Icons.engineering),
                _metricRow(
                    'Fuel Level',
                    latest.fuelLevel != null
                        ? '${latest.fuelLevel!.toStringAsFixed(1)}%'
                        : '—',
                    Icons.local_gas_station),
      ],
    )
  );
}
//2
 Widget _anomalyCard(ObdReading latest) {
    final isAnomaly = latest.isAnomaly ?? false;
    final score = latest.anomalyScore;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isAnomaly
              ? Colors.red.withOpacity(0.5)
              : const Color(0xFFECECEC),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('AI ANOMALY DETECTION',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _ObdScreenState._brandBlue,
                      letterSpacing: 0.5)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isAnomaly
                      ? Colors.red.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isAnomaly ? 'ANOMALY' : 'NORMAL',
                  style: TextStyle(
                    color: isAnomaly ? Colors.red : Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          if (score != null) ...[
            const SizedBox(height: 12),
            Text('Score: ${score.toStringAsFixed(4)}',
                style: const TextStyle(
                    fontSize: 14, color: Color(0xFF8A8A8A))),
            const SizedBox(height: 4),
            Text(
              score < 0
                  ? 'Negative score → far from normal values'
                  : 'Positive score → between normal parameters',
              style:
                  const TextStyle(fontSize: 12, color: Color(0xFF8A8A8A)),
            ),
          ],
        ],
      ),
    );
  }
  //3
  Widget _maintenanceCard(ObdReading latest) {
    // If-else pravila bazirana na pragovima + anomaly score
    final warnings = <String>[];

    if (latest.engineTemp != null && latest.engineTemp! > 105) {
      warnings.add(
          'Motor overheated (${latest.engineTemp!.toStringAsFixed(0)}°C) — check cooling system');
    }
    if (latest.rpm != null && latest.rpm! > 5500) {
      warnings.add('High RPM (${latest.rpm}) — caution!');
    }
    if (latest.fuelLevel != null && latest.fuelLevel! < 10) {
      warnings.add(
          'Low fuel level (${latest.fuelLevel!.toStringAsFixed(0)}%) — fill the tank!');
    }
    if (latest.engineLoad != null && latest.engineLoad! > 90) {
      warnings.add(
          'High engine load (${latest.engineLoad!.toStringAsFixed(0)}%) — drive slower');
    }
    if (latest.anomalyScore != null && latest.anomalyScore! < -0.1) {
      warnings.add(
          'AI detected unusual patterns — service recomended');
    }

    return _card(
      title: 'PREDICTIVE MAINTENANCE',
      child: warnings.isEmpty
          ? const Row(children: [
              Icon(Icons.check_circle, color: Colors.green, size: 20),
              SizedBox(width: 8),
              Text('All values are in normal range!',
                  style: TextStyle(color: Colors.green)),
            ])
          : Column(
              children: warnings
                  .map((w) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.warning_amber,
                                color: Colors.orange, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Text(w,
                                    style: const TextStyle(fontSize: 13))),
                          ],
                        ),
                      ))
                  .toList(),
            ),
    );
  }
Widget _trendCard(List<String> warnings) {
  final hasWarnings = warnings.isNotEmpty &&
      warnings.first != 'All values ​​in a stable trend';

  return _card(
    title: 'TREND DETECTION',
    child: warnings.isEmpty
        ? const Row(children: [
            Icon(Icons.trending_flat, color: Colors.grey, size: 20),
            SizedBox(width: 8),
            Text('There is not enough data to analyze',
                style: TextStyle(color: Colors.grey)),
          ])
        : Column(
            children: warnings.map((w) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    hasWarnings ? Icons.trending_up : Icons.check_circle,
                    color: hasWarnings ? Colors.orange : Colors.green,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(w, style: const TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            )).toList(),
          ),
  );
}
//helper
Widget _card({required String title, required Widget child})
{
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFFECECEC)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _ObdScreenState._brandBlue,
                  letterSpacing: 0.5)),
        const SizedBox(height: 14),
        child,
      ]
    ),
  );
}
Widget _metricRow(String label, String value, IconData icon)
{
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(
      children: [
        Icon(icon,size: 20,color: _ObdScreenState._brandBlue,),
        const SizedBox(width: 12,),
        Expanded(
          child: Text(label,style: const TextStyle(
                      color: Color(0xFF8A8A8A), fontSize: 14))),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14)),
         ],
      ),
    );
}
}
