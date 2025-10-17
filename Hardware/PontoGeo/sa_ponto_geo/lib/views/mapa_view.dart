import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/ponto_controller.dart';
import '../controllers/login_controller.dart';

class MapaView extends StatefulWidget {
  final double latitude;
  final double longitude;

  const MapaView({super.key, required this.latitude, required this.longitude});

  @override
  State<MapaView> createState() => _MapaViewState();
}

class _MapaViewState extends State<MapaView> {
  @override
  Widget build(BuildContext context) {
    final initialPosition = LatLng(widget.latitude, widget.longitude);

    return Scaffold(
      appBar: AppBar(title: const Text("Localização")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialPosition,
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("ponto"),
            position: initialPosition,
            infoWindow: const InfoWindow(title: "Ponto Registrado"),
          )
        },
      ),
    );
  }
}
