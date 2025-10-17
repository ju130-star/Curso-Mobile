import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //  Login com e-mail e senha (NIF será usado como parte do email)
  Future<User?> loginWithEmail(String nif, String senha) async {
    try {
      final email = "$nif@empresa.com"; // exemplo simples
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthError(e));
    }
  }

  // Registrar novo usuário (se quiser permitir cadastro)
  Future<User?> register(String nif, String senha) async {
    try {
      final email = "$nif@empresa.com";
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthError(e));
    }
  }

  //  Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  //  Usuário logado
  User? get currentUser => _auth.currentUser;

  // Tratamento de erros
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Usuário não encontrado.';
      case 'wrong-password':
        return 'Senha incorreta.';
      case 'invalid-email':
        return 'E-mail inválido.';
      default:
        return 'Erro ao autenticar: ${e.message}';
    }
  }
}
