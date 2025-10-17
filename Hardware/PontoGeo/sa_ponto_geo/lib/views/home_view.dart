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
  bool _carregando = false;
  Position? _posicaoAtual;

  // Coordenadas da empresa (exemplo: São Paulo)
  final double empresaLat = -23.5505;
  final double empresaLng = -46.6333;

  // Registra o ponto do usuário
  Future<void> registrarPonto() async {
    setState(() => _carregando = true);

    try {
      _posicaoAtual = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

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
          SnackBar(
            content: Text(
              "Ponto registrado às ${DateFormat('HH:mm:ss').format(agora)}",
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Fora da área de trabalho (100m)"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao registrar ponto: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Ponto"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (mounted) Navigator.pop(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _carregando ? null : registrarPonto,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: _carregando
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text("Registrar Ponto"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Histórico de Registros",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('registros')
                    .where('usuarioId', isEqualTo: uid)
                    .orderBy('dataHora', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text("Nenhum registro encontrado"));
                  }

                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;
                      final dt = DateTime.parse(data['dataHora']);
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text(
                              DateFormat('dd/MM/yyyy – HH:mm:ss').format(dt)),
                          subtitle: Text(
                              "Lat: ${data['latitude']} | Lng: ${data['longitude']}"),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
