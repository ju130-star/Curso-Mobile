
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart' show LocalAuthentication;

// ...existing code...
class BiometricService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> autenticarBiometricamente() async {
    try {
      final bool isSupported = await auth.isDeviceSupported();
      final bool canCheck = await auth.canCheckBiometrics;

      if (!isSupported || !canCheck) {
        throw Exception("Biometria não disponível neste dispositivo.");
      }

      final bool authenticated = await auth.authenticate(
        localizedReason: 'Confirme sua identidade...',
      );
      return authenticated;
    } on PlatformException catch (e) {
      throw Exception('Erro ao autenticar: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }
}
