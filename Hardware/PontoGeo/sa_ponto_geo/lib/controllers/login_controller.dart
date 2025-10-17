import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginController {
  final AuthService _authService = AuthService();

  final TextEditingController nifController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool isLoading = false;

  Future<bool> login() async {
    try {
      isLoading = true;
      final nif = nifController.text.trim();
      final senha = senhaController.text.trim();

      if (nif.isEmpty || senha.isEmpty) {
        throw Exception("Preencha todos os campos!");
      }

      await _authService.loginWithEmail(nif, senha);
      return true;
    } catch (e) {
      debugPrint("Erro no login: $e");
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}
