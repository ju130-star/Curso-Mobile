import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ponto_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //  Salvar ponto no Firestore
  Future<void> salvarPonto(PontoModel ponto) async {
    await _firestore
        .collection('usuarios')
        .doc(ponto.userId)
        .collection('pontos')
        .add(ponto.toMap());
  }

  //  Listar pontos de um usuário
  Future<List<PontoModel>> listarPontos(String userId) async {
    final snapshot = await _firestore
        .collection('usuarios')
        .doc(userId)
        .collection('pontos')
        .orderBy('data', descending: true)
        .orderBy('hora', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => PontoModel.fromMap(doc.data()))
        .toList();
  }
}
