import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/vehicles/vehicles_bloc.dart';
import '../blocs/vehicles/vehicles_event.dart';
import '../blocs/vehicles/vehicles_state.dart';
import '../models/vehicle.dart';
import 'vehicle_details_screen.dart';
import 'vehicle_form_screen.dart';

class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({super.key});

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  static const _brandBlue = Color(0xFF1A3B5D);

 
  final _searchController = TextEditingController();
  String _query = '';
  String _statusFilter = 'all'; 

  @override
  void initState() {
    super.initState();
    context.read<VehiclesBloc>().add(LoadVehicles());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  bool _matches(Vehicle v) {
    final s = v.status.toLowerCase();

    
    bool statusOk;
    switch (_statusFilter) {
      case 'active':
        statusOk = s == 'active';
        break;
      case 'maintenance':
        statusOk = s == 'maintenance';
        break;
      case 'inactive':
        statusOk = s != 'active' && s != 'maintenance'; // sve ostalo
        break;
      default:
        statusOk = true; // 'all'
    }

    // search
    final q = _query.toLowerCase();
    final queryOk = q.isEmpty ||
        v.registrationNumber.toLowerCase().contains(q) ||
        v.make.toLowerCase().contains(q) ||
        v.model.toLowerCase().contains(q);

    return statusOk && queryOk;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        title: const Text('Vehicles'),
        backgroundColor: _brandBlue,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const VehicleFormScreen()),
                );
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Add vehicle',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Column(
            children: [
              // search and filters
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() => _query = v),
                      decoration: InputDecoration(
                        hintText: 'Search(registration,make,model)',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _query.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _query = '');
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xFFECECEC)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xFFECECEC)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 8,
                        children: [
                          _filterChip('All', 'all'),
                          _filterChip('Active', 'active'),
                          _filterChip('Service', 'maintenance'),
                          _filterChip('Inactive', 'inactive'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<VehiclesBloc, VehicleState>(
                  builder: (context, state) {
                    if (state is VehicleLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is VehicleError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.error_outline,
                                  size: 48, color: Colors.red),
                              const SizedBox(height: 12),
                              Text('Greška: ${state.message}',
                                  textAlign: TextAlign.center),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<VehiclesBloc>()
                                    .add(LoadVehicles()),
                                child: const Text('Try again'),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is VehicleLoaded) {
                      
                      final filtered =
                          state.vehicles.where(_matches).toList();

                      if (filtered.isEmpty) {
                        return Center(
                          child: Text(
                            state.vehicles.isEmpty
                                ? 'No vehicles'
                                : 'No results',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async => context
                            .read<VehiclesBloc>()
                            .add(RefreshVehicles()),
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 16),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) =>
                              _VehicleCard(vehicle: filtered[index]),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 
  Widget _filterChip(String label, String value) {
    final selected = _statusFilter == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => setState(() => _statusFilter = value),
      selectedColor: _brandBlue,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black87,
        fontSize: 13,
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFECECEC)),
      ),
    );
  }
}

class _VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  const _VehicleCard({required this.vehicle});

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
    return Card(
      margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFECECEC)),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF1A3B5D),
          child: Icon(Icons.directions_car, color: Colors.white),
        ),
        title: Text('${vehicle.make} ${vehicle.model}',
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
            '${vehicle.registrationNumber} • ${vehicle.currentOdometer} km'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _statusColor(vehicle.status).withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            vehicle.status,
            style: TextStyle(
              color: _statusColor(vehicle.status),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => VehicleDetailsScreen(vehicle: vehicle),
            ),
          );
        },
      ),
    );
  }
}