import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/ponto_model.dart';
import '../services/geolocator_service.dart';
import '../services/firebase_service.dart';

class PontoController {
  final FirebaseService _firebaseService = FirebaseService();
  final GeolocatorService _geoService = GeolocatorService();

  bool isLoading = false;

  Future<bool> registrarPonto(String userId) async {
    try {
      isLoading = true;

      // Obtém localização atual
      final posicao = await _geoService.getCurrentPosition();

      // Cria o ponto com data e hora atual
      final ponto = PontoModel(
        userId: userId,
        data: DateFormat('dd/MM/yyyy').format(DateTime.now()),
        hora: DateFormat('HH:mm:ss').format(DateTime.now()),
        latitude: posicao.latitude,
        longitude: posicao.longitude,
      );

      // Salva no Firestore
      await _firebaseService.salvarPonto(ponto);
      return true;
    } catch (e) {
      debugPrint("Erro ao registrar ponto: $e");
      return false;
    } finally {
      isLoading = false;
    }
  }
}
