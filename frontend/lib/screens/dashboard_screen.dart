import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/vehicles/vehicles_bloc.dart';
import '../blocs/vehicles/vehicles_event.dart';
import '../blocs/vehicles/vehicles_state.dart';
import '../models/vehicle.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen>
{
@override
void initState()
{
 super.initState();
 context.read<VehiclesBloc>().add(LoadVehicles());
}
@override
Widget build(BuildContext context)
{
  return Scaffold(
    backgroundColor: const Color(0xFFF4F5F7),
    body: BlocBuilder<VehiclesBloc,VehicleState>(
      builder: (context, state){
        if (state is VehicleLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is VehicleError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is VehicleLoaded) {
            return _buildDashboard(state.vehicles);
          }
          return const SizedBox.shrink();
      }
    )
  );
}
}
Widget _buildDashboard(List<Vehicle>vehicles)
{
  final total=vehicles.length;
  final active=vehicles.where((v)=>v.status.toLowerCase()=='active').length;
  final inactive=vehicles.where((v)=>v.status.toLowerCase()=='inactive').length;
  final maintenance=vehicles.where((v)=>v.status.toLowerCase()=='maintenance').length;
  final needsAttention=vehicles.where((v)=>v.status.toLowerCase()!='active').toList();
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Dashboard",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: _metricCard(
                      'Total vehicles', '$total', Colors.black87)),
              const SizedBox(width: 12),
              Expanded(
                  child: _metricCard(
                      'Active', '$active', const Color(0xFF0F6E56))),
              const SizedBox(width: 12),
              Expanded(
                  child: _metricCard(
                      'On service', '$maintenance', const Color(0xFF854F0B))),
              const SizedBox(width: 12),
              Expanded(
                  child: _metricCard('Inactive', '$inactive',
                      const Color(0xFFA32D2D))),
          ],
        ),
        const SizedBox(height: 20),

          _statusBar(active, maintenance, inactive),
          const SizedBox(height: 16),

          _needsAttentionCard(needsAttention),
      ],
    ),
  );
}
Widget _metricCard(String label, String value, Color valueColor)
{
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
              style: TextStyle(fontSize: 13, color: Colors.grey[600])),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: valueColor)),
      ],
    ),
  );
}
Widget _statusBar(int active, int maintenance, int outOfService)
{
  final segments = <Widget>[];
  if(active>0)
  {
    segments.add(Expanded(
      flex: active, child: Container(color: const Color(0xFF1D9E75))));}
      if (maintenance > 0) {
      segments.add(Expanded(
          flex: maintenance,
          child: Container(color: const Color(0xFFEF9F27))));
    }
    if (outOfService > 0) {
      segments.add(Expanded(
          flex: outOfService,
          child: Container(color: const Color(0xFFE24B4A))));
    }
    if (segments.isEmpty) {
      segments.add(Expanded(child: Container(color: Colors.grey.shade300)));
    }
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fleet status',style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),     
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: SizedBox(height: 14, child: Row(children: segments)),
          ),
          const SizedBox(height: 10),
          Wrap(//when no space on screen wrap puts elements in new row
            spacing: 18,
            children: [
              _legend(const Color(0xFF1D9E75), 'Active $active'),
              _legend(const Color(0xFFEF9F27), 'Maintenance $maintenance'),
              _legend(const Color(0xFFE24B4A), 'Out of service $outOfService'),
            ],
          )
        ],
      ),
    );
  }

Widget _legend(Color color, String text)
{
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
        Container(
            width: 9,
            height: 9,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 5),
        Text(text,
            style: TextStyle(fontSize: 12, color: Colors.grey[700])),
      ],
  );
}
Widget _needsAttentionCard(List<Vehicle> vehicles)
{
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.black12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Attention',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          if (vehicles.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text('All vehicles are active ✓',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            )
          else
            ...vehicles.map(_attentionRow),
      ],
    ),
  );
}
Widget _attentionRow(Vehicle v)
{
  final isMaintenance = v.status.toLowerCase() == 'maintenance';
  final color =
      isMaintenance ? const Color(0xFF854F0B) : const Color(0xFFA32D2D);
  final bg =
      isMaintenance ? const Color(0xFFFAEEDA) : const Color(0xFFFCEBEB);
  final label = isMaintenance ? 'Service' : 'Inactive';
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(isMaintenance ? Icons.build : Icons.warning_amber,
              size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(
              child: Text('${v.registrationNumber} · ${v.make} ${v.model}',
                  style: const TextStyle(fontSize: 13))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(
                color: bg, borderRadius: BorderRadius.circular(20)),
            child: Text(label, style: TextStyle(fontSize: 12, color: color)),
          ),
        ],
      ),
    );
  }