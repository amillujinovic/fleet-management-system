import  'package:flutter/material.dart';
import '../models/vehicle.dart';
import 'vehicle_form_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/vehicles/vehicles_bloc.dart';
import '../blocs/vehicles/vehicles_event.dart';
import '../blocs/vehicles/vehicles_state.dart';
class VehicleDetailsScreen extends StatelessWidget {
  final Vehicle vehicle;
  const VehicleDetailsScreen({super.key, required this.vehicle});
  static const _brandBlue=Color(0xFF1A3B5D);
  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'maintenance':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
 @override
Widget build(BuildContext context) {
  return BlocListener<VehiclesBloc, VehicleState>(
    
    listener: (context, state) {
      if (state is VehicleDeleted) {
        final messenger = ScaffoldMessenger.of(context);
        final navigator = Navigator.of(context);
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Deleted!'),
            backgroundColor: Colors.green,
          ),
        );
        navigator.popUntil((route) => route.isFirst);
      } else if (state is VehicleError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${state.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    },

    child: Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        title: Text('${vehicle.make} ${vehicle.model}'),
        backgroundColor: _brandBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => VehicleFormScreen(vehicle: vehicle)),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final bloc = context.read<VehiclesBloc>();
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete vehicle?'),
                  content: Text(
                      'Are you sure that you want do delete: ${vehicle.make} ${vehicle.model}?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(true),
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                bloc.add(DeleteVehicle(vehicleId: vehicle.id));
              }
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _headerCart(),
              const SizedBox(height: 14),
              _sectionCard('Basic informations', [
                _infoRow('Registration', vehicle.registrationNumber),
                _infoRow('VIN', vehicle.vin ?? '—'),
                _infoRow('Year', vehicle.year.toString()),
                _infoRow('Vehicle type', vehicle.vehicleType),
                _infoRow('Fuel type', vehicle.fuelType),
              ]),
              const SizedBox(height: 14),
              _sectionCard('Specifications', [
                _infoRow('Current odometer', '${vehicle.currentOdometer} km'),
                _infoRow(
                    'Tank Capacity',
                    vehicle.fuelTankCapacity != null
                        ? '${vehicle.fuelTankCapacity} L'
                        : '—'),
                _infoRow(
                    'Load Capacity',
                    vehicle.loadCapacity != null
                        ? '${vehicle.loadCapacity} kg'
                        : '—'),
              ]),
            ],
          ),
        ),
      ),
    ),
  );
}
  
  Widget _headerCart()
  {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:Colors.white,
        border: Border.all(color: const Color(0xFFECECEC)),
        borderRadius: BorderRadius.circular(12),
      ),
      child:Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: VehicleDetailsScreen._brandBlue,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.directions_car,size: 28,color: Colors.white,),
          ),
          const SizedBox(width: 16,),
          Expanded( //expanded is used to fill remaining space when using Row/Column/Flex
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${vehicle.make} ${vehicle.model}',
                  style:const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600
                    )
                  ),
              const SizedBox(height: 3,),
              Text(vehicle.registrationNumber,
              style: TextStyle(fontSize: 13,color: Color(0xFF8A8A8A)))
            ],
          ), 
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
            decoration:BoxDecoration( color: _statusColor(vehicle.status).withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),),
              child:Text(
                vehicle.status,
                style: TextStyle(
                  color:_statusColor(vehicle.status),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),

              )
          )

        ],
      )
    );
  }
  Widget _sectionCard(String title,List<Widget> rows)
  {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFECECEC)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(),
          style:const TextStyle(
            fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _brandBlue,
                letterSpacing: 0.5,
          )),
          const SizedBox(height: 10,),
          ...rows,
        ],
      ),
    );
}
Widget _infoRow(String label,String value)
{
  return Padding( 
  padding: const EdgeInsets.symmetric(vertical: 7),
  child:Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,style: const TextStyle(fontSize: 14, color: Color(0xFF8A8A8A))),
      
      Text(
        value,style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    ],
  )
  );
}
}