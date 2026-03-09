import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
class HealthcareProfessionalsScreen extends StatefulWidget {
  const HealthcareProfessionalsScreen({super.key});

  @override
  State<HealthcareProfessionalsScreen> createState() =>
      _HealthcareProfessionalsScreenState();
}

class _HealthcareProfessionalsScreenState
    extends State<HealthcareProfessionalsScreen> {

  LatLng _currentPosition = LatLng(-26.2041, 28.0473); // Default Johannesburg
  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _loadNearbyClinics();
  }

  Future<void> _determinePosition() async {

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void _loadNearbyClinics() {

    final clinics = [
      {"name": "Johannesburg Central Clinic", "lat": -26.2045, "lng": 28.0475},
      {"name": "Hillbrow Hospital", "lat": -26.2029, "lng": 28.0500},
      {"name": "Sandton Medical Center", "lat": -26.1076, "lng": 28.0567},
    ];

    for (var clinic in clinics) {
      _markers.add(
        Marker(
          point: LatLng(clinic["lat"] as double, clinic["lng"] as double),
          width: 80,
          height: 80,
          child: const Icon(
            Icons.local_hospital,
            color: Colors.red,
            size: 40,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Healthcare Professionals"),
        backgroundColor: const Color(0xFF1F6F68),
      ),

      body: FlutterMap(
        options: MapOptions(
          initialCenter: _currentPosition,
          initialZoom: 14,
          maxZoom: 18,
        ),

        children: [

          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a','b','c'],
          ),

          MarkerLayer(
            markers: [

              ..._markers,

              Marker(
                point: _currentPosition,
                width: 80,
                height: 80,
                child: const Icon(
                  Icons.person_pin_circle,
                  color: Colors.blue,
                  size: 40,
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}