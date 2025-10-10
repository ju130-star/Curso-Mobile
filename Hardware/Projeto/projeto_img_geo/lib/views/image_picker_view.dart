// lib/views/image_picker_view.dart
import 'package:flutter/material.dart';
import '../controllers/foto_controller.dart';
import '../models/foto_model.dart';

class ImagePickerView extends StatefulWidget {
  const ImagePickerView({super.key});

  @override
  State<ImagePickerView> createState() => _ImagePickerViewState();
}

class _ImagePickerViewState extends State<ImagePickerView> {
  final FotoController _controller = FotoController();

  void _mostrarInfoDialog(FotoModel foto) {
    if (foto.localizacao != null && foto.data != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Informações da Foto"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("📍 Local: ${foto.localizacao}"),
              const SizedBox(height: 10),
              Text("📅 Data: ${foto.data}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fechar"),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _tirarFoto() async {
    try {
      await _controller.tirarFoto();
      setState(() {});
    } catch (e) {
      _mostrarErro(e.toString());
    }
  }

  Future<void> _escolherDaGaleria() async {
    try {
      await _controller.escolherDaGaleria();
      setState(() {});
    } catch (e) {
      _mostrarErro(e.toString());
    }
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  @override
  Widget build(BuildContext context) {
    FotoModel foto = _controller.foto;

    return Scaffold(
      appBar: AppBar(title: const Text("Foto com Localização")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            foto.imagem != null
                ? GestureDetector(
                    onTap: () => _mostrarInfoDialog(foto),
                    child: Image.file(foto.imagem!, height: 300),
                  )
                : const Text("Nenhuma Imagem Selecionada"),

            const SizedBox(height: 20),

            ElevatedButton(
                onPressed: _tirarFoto, child: const Text("Tirar Foto")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: _escolherDaGaleria,
                child: const Text("Escolher da Galeria")),

            const SizedBox(height: 20),

            if (foto.localizacao != null && foto.data != null)
              Column(
                children: [
                  Text(
                    "📍 ${foto.localizacao}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "📅 ${foto.data}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
