import 'package:flutter/material.dart';
import '../controllers/historico_controller.dart';
import '../controllers/login_controller.dart';
import '../widgets/ponto_card.dart';
// ...existing code...

class HistoricoView extends StatefulWidget {
  const HistoricoView({super.key});

  @override
  State<HistoricoView> createState() => _HistoricoViewState();
}

class _HistoricoViewState extends State<HistoricoView> {
  final HistoricoController _controller = HistoricoController();
  final LoginController _loginController = LoginController();

  @override
  void initState() {
    super.initState();
    // agenda a carga para depois do primeiro frame (mais seguro)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = _loginController.nifController.text;
      if (user.isNotEmpty) {
        _controller.carregarHistorico(user);
      }
    });
  }

  @override
  void dispose() {
    // Se HistoricoController tiver dispose, descomente a linha abaixo:
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico de Pontos"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: _controller.isLoadingNotifier,
        builder: (_, isLoading, __) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_controller.pontos.isEmpty) {
            return const Center(
              child: Text("Nenhum ponto registrado."),
            );
          }

          return ListView.builder(
            itemCount: _controller.pontos.length,
            itemBuilder: (_, index) {
              final ponto = _controller.pontos[index];
              return PontoCard(
                dataHora: ponto.dataHora,
                latitude: ponto.latitude,
                longitude: ponto.longitude,
              );
            },
          );
        },
      ),
    );
  }
}


