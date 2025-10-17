import 'package:flutter/material.dart';
import '../controllers/historico_controller.dart';
import '../controllers/login_controller.dart';
import '../widgets/ponto_card.dart';
import 'home_view.dart';

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
    // Pega o usuário logado de forma pública
    final user = _loginController.user;
    if (user != null) {
      _controller.carregarHistorico(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico de Pontos"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // volta para a tela anterior (HomeView)
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
              return PontoCard(ponto: ponto);
            },
          );
        },
      ),
    );
  }
}
