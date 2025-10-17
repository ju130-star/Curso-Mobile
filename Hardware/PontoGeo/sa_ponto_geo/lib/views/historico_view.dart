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
    final userId = _loginController._authService.currentUser?.uid ?? '';
    _controller.carregarHistorico(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico de Pontos"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeView()),
            );
          },
        ),
      ),
      body: _controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _controller.pontos.length,
              itemBuilder: (_, index) {
                final ponto = _controller.pontos[index];
                return PontoCard(ponto: ponto);
              },
            ),
    );
  }
}
