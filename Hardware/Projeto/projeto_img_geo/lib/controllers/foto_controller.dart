// lib/controllers/foto_controller.dart
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import '../models/foto_model.dart';

class FotoController {
  final ImagePicker _picker = ImagePicker();
  final FotoModel _foto = FotoModel();

  FotoModel get foto => _foto;

  // Obter localização e data/hora
  Future<void> obterLocalizacaoEData() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception("Serviço de localização desativado.");

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permissão de localização negada.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Permissão de localização permanentemente negada.");
    }

    // Obtém posição e endereço
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks[0];
    String dataFormatada = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

    _foto.localizacao =
        '${place.street}, ${place.subLocality}, ${place.locality} - ${place.administrativeArea}';
    _foto.data = dataFormatada;
  }

  // Capturar imagem pela câmera
  Future<void> tirarFoto() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _foto.imagem = File(pickedFile.path);
      _foto.localizacao = null;
      _foto.data = null;
      await obterLocalizacaoEData();
    }
  }

  // Escolher imagem da galeria
  Future<void> escolherDaGaleria() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _foto.imagem = File(pickedFile.path);
      _foto.localizacao = null;
      _foto.data = null;
      await obterLocalizacaoEData();
    }
  }
}
