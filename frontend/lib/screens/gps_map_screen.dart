import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/gps_service.dart';

class GpsMapScreen extends StatefulWidget {
  const GpsMapScreen({super.key});
  @override
  State<GpsMapScreen> createState() => _GpsMapScreenState();
}
class _GpsMapScreenState extends State<GpsMapScreen>
{
  static const int _vehicleId=1; //ID OF ESP DEVICE
  final _gpsService = GpsService();
  final _mapController = MapController();
  List<GpsPoint> _history = [];
  static const double _speedLimit = 20.0;
  GpsPoint? _point;       
  DateTime? _lastFetch;   
  String? _error;         
  Timer? _timer;          
  bool _firstFix = true;
  @override
  void initState()
  {
    super.initState();
    _fetch();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => _fetch());
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  Future<void> _fetch() async
  {
    try
    {
      final p=await _gpsService.getLatestForVehicle(_vehicleId); //positon
      final history = await _gpsService.getHistory(_vehicleId); // NOVO
      if(!mounted) return; //if user is not in card dont touch state
      setState(() {
        _point=p;
        _history = history;
        _lastFetch=DateTime.now();
        _error=null;
      });
      if(p!=null)
      {
        final target=LatLng(p.latitude,p.longitude);
        if(_firstFix)
        {
          _mapController.move(target, 15); //if its first time zoom to the vehicle, if not zoom stays and follow
          _firstFix = false;
        }
        else{
          _mapController.move(target,_mapController.camera.zoom);
        }
      }
    }
    catch(e)
    {
      if (!mounted) return;
      setState(() => _error = e.toString());
    }
  }
  String _timeAgo(DateTime t) {
    final s = DateTime.now().difference(t).inSeconds;
    return s < 5 ? 'now' : 'before ${s}s';
  }
  List<Polyline> _buildRouteSegments() {
  final segments = <Polyline>[];
  for (int i = 0; i < _history.length - 1; i++) {
    final a = _history[i];
    final b = _history[i + 1];
    if (a.recordedAt != null && b.recordedAt != null) {
    final gap = b.recordedAt!.difference(a.recordedAt!).inSeconds.abs();
     if (gap > 60) continue;}
    final bool overSpeed = (b.speed ?? 0) > _speedLimit;

    segments.add(
      Polyline(
        points: [
          LatLng(a.latitude, a.longitude),
          LatLng(b.latitude, b.longitude),
        ],
        strokeWidth: 5,
        color: overSpeed ? Colors.red : const Color(0xFF185FA5),
      ),
    );
  }
  return segments;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Stack(
        children: [
          //layer 1 MAP
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(initialCenter: LatLng(43.8563, 18.4131), // Sarajevo
              initialZoom: 13,),
            children: [
              TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.fleet_management_app',
              ),
              PolylineLayer(polylines: _buildRouteSegments()), // NOVO - ruta
              if (_point != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(_point!.latitude, _point!.longitude),
                      width: 44,
                      height: 44,
                      // child = kako marker IZGLEDA (ovdje pin ikonica).
                      child: const Icon(Icons.location_on,
                          color: Color(0xFF1A3B5D), size: 44),
                    ),
            ],
                ),
            ],
          ),
          Positioned(top: 14, left: 14, right: 14, child: _infoCard()), //positioned says where inside stack it is
          Positioned(
            bottom: 20,
            right: 16,
            child: FloatingActionButton.small(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1A3B5D),
              // Na klik: vrati mapu na vozilo i zumiraj.
              onPressed: () {
                if (_point != null) {
                  _mapController.move(
                      LatLng(_point!.latitude, _point!.longitude), 15);
                }
              },
              child: const Icon(Icons.my_location),
           ),
          ),
        ],
      ),
    );
  }
  Widget _infoCard()
{
  String coords;
    String update;
    Color dot; 
    if (_error != null) {
      // Stanje 1: dohvat pukao
      coords = 'Nema podataka';
      update = 'Greška pri dohvatu';
      dot = Colors.red;
    } else if (_point == null) {
      
      coords = 'Waiting GPS data...';
      update = '—';
      dot = Colors.orange;
    } else
    {
      coords='${_point!.latitude.toStringAsFixed(5)}, ${_point!.longitude.toStringAsFixed(5)}';
      update = _lastFetch != null ? 'Last update: ${_timeAgo(_lastFetch!)}' : '';
      dot = Colors.green;
    }return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          // Statusna tačkica
          Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: dot, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ESP32 · Vehicle number: #$_vehicleId',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(coords,
                    style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                Text(update,
                    style: TextStyle(fontSize: 11, color: Colors.grey[500])),
              ],
            ),
          ),
          if (_point?.speed != null)
            Text('${_point!.speed!.toStringAsFixed(0)} km/h',
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w500)),
],
      ),
    );
  }
}
