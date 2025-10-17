import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Position? _posicaoAtual;
  bool _carregando = false;
  final double empresaLat = -23.5505; // Exemplo SP
  final double empresaLng = -46.6333; // Exemplo SP

  Future<void> registrarPonto() async {
    setState(() => _carregando = true);
    _posicaoAtual = await Geolocator.getCurrentPosition();

    double distancia = Geolocator.distanceBetween(
      _posicaoAtual!.latitude,
      _posicaoAtual!.longitude,
      empresaLat,
      empresaLng,
    );

    if (distancia <= 100) {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final agora = DateTime.now();

      await FirebaseFirestore.instance.collection('registros').add({
        'usuarioId': uid,
        'dataHora': agora.toIso8601String(),
        'latitude': _posicaoAtual!.latitude,
        'longitude': _posicaoAtual!.longitude,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ponto registrado às ${DateFormat('HH:mm:ss').format(agora)}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fora da área de trabalho (100m)")),
      );
    }

    setState(() => _carregando = false);
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Ponto"),
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut().then(
                  (_) => Navigator.pop(context),
                ),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _carregando ? null : registrarPonto,
            child: _carregando
                ? const CircularProgressIndicator()
                : const Text("Registrar Ponto"),
          ),
          const SizedBox(height: 20),
          const Text("Histórico de Registros"),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('registros')
                  .where('usuarioId', isEqualTo: uid)
                  .orderBy('dataHora', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (_, i) {
                    final data = docs[i].data() as Map<String, dynamic>;
                    final dt = DateTime.parse(data['dataHora']);
                    return ListTile(
                      title: Text(DateFormat('dd/MM/yyyy – HH:mm:ss').format(dt)),
                      subtitle: Text("Lat: ${data['latitude']} | Lng: ${data['longitude']}"),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
