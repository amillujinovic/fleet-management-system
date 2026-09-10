import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/vehicles/vehicles_bloc.dart';
import '../blocs/vehicles/vehicles_event.dart';
import '../blocs/vehicles/vehicles_state.dart';
import '../models/vehicle.dart';

class VehicleFormScreen extends StatefulWidget 
{ final Vehicle? vehicle;
  const VehicleFormScreen({super.key, this.vehicle});
  @override
  State<VehicleFormScreen> createState() => _VehicleFormScreenState();
}
class _VehicleFormScreenState extends State<VehicleFormScreen>
{
   static const _brandBlue = Color(0xFF1A3B5D);
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _regController;
  late final TextEditingController _makeController;
  late final TextEditingController _modelController;
  late final TextEditingController _yearController;
  late final TextEditingController _typeController;
  late final TextEditingController _fuelController;
  late final TextEditingController _odometerController;
  String _status = 'Active';

  bool get _isEdit => widget.vehicle != null;
  @override
  void initState()
  {
    super.initState();
    final v=widget.vehicle;
    //if i just edit data fill them with existing
    _regController = TextEditingController(text: v?.registrationNumber ?? '');
    _makeController = TextEditingController(text: v?.make ?? '');
    _modelController = TextEditingController(text: v?.model ?? '');
    _yearController = TextEditingController(text: v?.year.toString() ?? '');
    _typeController = TextEditingController(text: v?.vehicleType ?? '');
    _fuelController = TextEditingController(text: v?.fuelType ?? '');
    _odometerController =
        TextEditingController(text: v?.currentOdometer.toString() ?? '');
    if (v != null) _status = v.status;
  }
  @override
  void dispose() {
    _regController.dispose();
    _makeController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _typeController.dispose();
    _fuelController.dispose();
    _odometerController.dispose();
    super.dispose();
  }
  void _onSave()
  {
    if(!_formKey.currentState!.validate()) return;
    final vehicle=Vehicle(
      id:widget.vehicle?.id??0,
      registrationNumber: _regController.text.trim(),
      make:_makeController.text.trim(),
      model:_modelController.text.trim(),
      year: int.parse(_yearController.text.trim()),
      vehicleType: _typeController.text.trim(),
      fuelType: _fuelController.text.trim(),
      status: _status,
      currentOdometer: int.parse(_odometerController.text.trim()),
      createdAt: widget.vehicle?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
    if (_isEdit) {
      context.read<VehiclesBloc>().add(UpdateVehicle(vehicle: vehicle));
    } else {
      context.read<VehiclesBloc>().add(CreateVehicle(vehicle: vehicle));
    }
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        title: Text('Add/Edit vehicle'),
        backgroundColor:_brandBlue,
        foregroundColor: Colors.white,
        ),
        body: BlocListener<VehiclesBloc, VehicleState>(
          listener: (context, state){
            if(state is VehicleCreated || state is VehicleUpdated)
            { 
              final messenger = ScaffoldMessenger.of(context);
              final navigator = Navigator.of(context);
              messenger.showSnackBar(
                const SnackBar(
                  content: Text("Saved!"),
                  backgroundColor: Colors.green,
                ),
              );
              navigator.popUntil((route) => route.isFirst);
            }
            else if(state is VehicleError)
            {
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
            }
          },
        child: Center(
          child:SingleChildScrollView(
            padding:const EdgeInsets.all(20),
            child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 460),
            child: Container(
              padding:const EdgeInsets.all(26),
              decoration: BoxDecoration(
                color: Colors.white,
                  border: Border.all(color: const Color(0xFFECECEC)),
                  borderRadius: BorderRadius.circular(14),
              ),
              child: Form( 
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _field(_regController, 'Registration *'),
                      const SizedBox(height: 14),
                      _field(_makeController, 'Make *'),
                      const SizedBox(height: 14),
                      _field(_modelController, 'Model *'),
                      const SizedBox(height: 14),
                      _field(_yearController, 'Year *', number: true),
                      const SizedBox(height: 14),
                      _field(_typeController, 'Type *'),
                      const SizedBox(height: 14),
                      _field(_fuelController, 'Fuel Type *'),
                      const SizedBox(height: 14),
                      _field(_odometerController, 'Milage *',
                          number: true),
                      const SizedBox(height: 14),
                      DropdownButtonFormField<String>(
                        value: _status,
                        decoration: const InputDecoration(
                          labelText: 'Status *',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: 'Active', child: Text('Active')),
                          DropdownMenuItem(
                              value: 'Maintenance',
                              child: Text('Maintenance')),
                          DropdownMenuItem(
                              value: 'Inactive', child: Text('Inactive')),
                        ],
                        onChanged: (val) =>
                            setState(() => _status = val ?? 'Active'),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _onSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _brandBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Save',
                          style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )
                ],
              ),
              ),
            )
            
            ),
          )

        ),
        )
      );
    
  }
  }
  Widget _field(TextEditingController c, String label,
      {bool number = false})
  {
    return TextFormField(
      controller: c,
      keyboardType: number ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Obavezno polje';
        if (number && int.tryParse(v.trim()) == null) {
          return 'Mora biti broj';
        }
        return null;
      },
    );
  }