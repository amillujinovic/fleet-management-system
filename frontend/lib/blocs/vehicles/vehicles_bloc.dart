import 'package:fleet_management_app/blocs/vehicles/vehicles_event.dart';
import 'package:fleet_management_app/blocs/vehicles/vehicles_state.dart';
import 'package:fleet_management_app/models/vehicle.dart';
import 'package:fleet_management_app/services/vehicle_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehiclesBloc extends Bloc<VehiclesEvent,VehicleState> 
{
  final VehicleService _vehicleService;
  List<Vehicle> _allVehicles=[]; //cache for all vehicles to enable filtering and searching without additional API calls
  VehiclesBloc({VehicleService? vehicleService})
      : _vehicleService = vehicleService ?? VehicleService(),
        super(VehicleInitial())
  {
    on<LoadVehicles>(_onLoadVehicles);
    on<LoadVehicleDetails>(_onLoadVehicleDetails);
    on<FilterVehiclesByStatus>(_onFilterVehiclesByStatus);
    on<SearchVehicles>(_onSearchVehicles);
    on<CreateVehicle>(_onCreateVehicle);
    on<UpdateVehicle>(_onUpdateVehicle);
    on<DeleteVehicle>(_onDeleteVehicle);
    on<RefreshVehicles>(_onRefreshVehicles);   
  }
  Future<void> _onLoadVehicles(LoadVehicles event,Emitter<VehicleState> emit) async
  {
    emit(VehicleLoading());
    try {
      
      final vehicles=await _vehicleService.getAllVehicles();
      _allVehicles=vehicles;
      emit(VehicleLoaded(vehicles:vehicles));
    } catch (e) {
      emit(VehicleError(message:e.toString()));
    }
  }
  Future<void> _onLoadVehicleDetails(LoadVehicleDetails event,Emitter<VehicleState> emit) async
  {
    emit(VehicleLoading());
    try {
      
      final vehicle= await _vehicleService.getVehicleById(event.vehicleId);
      emit(VehicleDetailsLoaded(vehicle:vehicle));
    } catch (e) {
      emit(VehicleError(message:e.toString()));
    }
  }
  Future<void> _onFilterVehiclesByStatus(FilterVehiclesByStatus event,Emitter<VehicleState> emit) async
  {
    if(event.status.isEmpty || event.status=='all') //if user wants to see all
    {
      emit(VehicleLoaded(vehicles:_allVehicles));
    }
    else
    {
      final filtered=_allVehicles
      .where((v)=>v.status.toLowerCase()==event.status.toLowerCase())
      .toList();
      emit(VehicleLoaded(vehicles: filtered));
    }
  }
  Future<void> _onSearchVehicles(SearchVehicles event,Emitter<VehicleState> emit) async
  {
    if(event.query.isEmpty)
    {
      emit(VehicleLoaded(vehicles: _allVehicles));
    }
    else {
      final q = event.query.toLowerCase();
      final results = _allVehicles.where((v) {
        return v.make.toLowerCase().contains(q) ||
            v.model.toLowerCase().contains(q) ||
            v.registrationNumber.toLowerCase().contains(q);
      }).toList();
      emit(VehicleLoaded(vehicles: results));
    }
  }
  Future<void> _onCreateVehicle(CreateVehicle event,Emitter<VehicleState> emit) async
  {
    emit(VehicleLoading());
    try
    {
      final created= await _vehicleService.createVehicle(event.vehicle);
      await _reloadAndEmit(emit);
      emit(VehicleLoaded(vehicles: _allVehicles));
    }
    catch(e)
    {
      emit(VehicleError(message:e.toString()));
    }
  }
  Future<void> _onUpdateVehicle(UpdateVehicle event,Emitter<VehicleState> emit) async
  {
    emit(VehicleLoading());
    try
    {
      final update=await _vehicleService.updateVehicle(event.vehicle.id,event.vehicle);
      await _reloadAndEmit(emit);
      emit(VehicleLoaded(vehicles: _allVehicles));
    }
    catch(e)
    {
      emit(VehicleError(message:e.toString()));
    }
  }
  Future<void> _onDeleteVehicle(DeleteVehicle event,Emitter<VehicleState> emit) async
  {
    emit(VehicleLoading());
    try
    {
       print('1. prije delete');
    await _vehicleService.deleteVehicle(event.vehicleId);
    print('2. delete OK, emitujem VehicleDeleted');
    emit(VehicleDeleted(vehicleId: event.vehicleId));
    print('3. prije reload');
    await _reloadAndEmit(emit);
    print('4. reload gotov');
  } catch (e) {
    print('GREŠKA: $e');
    emit(VehicleError(message: e.toString()));
    }
    catch(e)
  {
    emit(VehicleError(message:e.toString()));
  }
  }
  Future<void> _onRefreshVehicles(RefreshVehicles event,Emitter<VehicleState> emit) async
  {
    try
    {
      await _reloadAndEmit(emit);
    }
    catch(e)
    {
      emit(VehicleError(message:e.toString()));
    }
    }
    Future<void> _reloadAndEmit(Emitter<VehicleState> emit) async
  //when some change happens on server local memory does not know about it so i refresh it to check
  {
    final vehicles= await _vehicleService.getAllVehicles();
    _allVehicles=vehicles;
    emit(VehicleLoaded(vehicles:vehicles));
  }
  }
  
