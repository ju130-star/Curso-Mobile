import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PontoCard extends StatelessWidget {
  final DateTime dataHora;
  final double latitude;
  final double longitude;

  const PontoCard({
    super.key,
    required this.dataHora,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: const Icon(Icons.location_on),
        title: Text(DateFormat('dd/MM/yyyy – HH:mm:ss').format(dataHora)),
        subtitle: Text("Lat: $latitude | Lng: $longitude"),
      ),
    );
  }
}
