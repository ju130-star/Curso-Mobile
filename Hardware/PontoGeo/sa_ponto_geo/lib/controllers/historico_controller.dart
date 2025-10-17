import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import '../models/ponto_model.dart';
import '../services/firebase_service.dart';

class HistoricoController extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();

  List<PontoModel> pontos = [];
  bool isLoading = false;

  ValueListenable<bool> get isLoadingNotifier => ValueNotifier(isLoading);

  Future<void> carregarHistorico(String userId) async {
    try {
      isLoading = true;
      pontos = await _firebaseService.listarPontos(userId);
      notifyListeners();
    } catch (e) {
      debugPrint("Erro ao carregar histórico: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
