import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sa_biblioteca/controllers/emprestimo_controller.dart';
import 'package:sa_biblioteca/models/emprestimo_model.dart';
import 'package:sa_biblioteca/view/detalhe_livro_screen.dart';

class CadastroEmprestimoScreen extends StatefulWidget {
  final int livroId;

  const CadastroEmprestimoScreen({super.key, required this.livroId});

  @override
  State<CadastroEmprestimoScreen> createState() => _CadastroEmprestimoScreenState();
}

class _CadastroEmprestimoScreenState extends State<CadastroEmprestimoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emprestimoController = EmprestimoController();

  late String _nomeLocatario;
  DateTime _dataEmprestimo = DateTime.now();
  DateTime _previsaoDevolucao = DateTime.now().add(Duration(days: 7));

  Future<void> _selecionarDataEmprestimo(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataEmprestimo,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Color(0xFF8D6748), // Marrom
            onPrimary: Color(0xFFF5E9DA), // Bege claro
            surface: Color(0xFFF5E9DA),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null && picked != _dataEmprestimo) {
      setState(() {
        _dataEmprestimo = picked;
      });
    }
  }

  Future<void> _selecionarPrevisaoDevolucao(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _previsaoDevolucao,
      firstDate: _dataEmprestimo,
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Color(0xFF8D6748),
            onPrimary: Color(0xFFF5E9DA),
            surface: Color(0xFFF5E9DA),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null && picked != _previsaoDevolucao) {
      setState(() {
        _previsaoDevolucao = picked;
      });
    }
  }

  Future<void> _salvarEmprestimo() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final novoEmprestimo = Emprestimo(
        livroId: widget.livroId,
        nomeLocatario: _nomeLocatario,
        dataEmprestimo: _dataEmprestimo,
        previsaoDevolucao: _previsaoDevolucao,
      );

      try {
        await _emprestimoController.createEmprestimo(novoEmprestimo);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Empréstimo registrado com sucesso")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DetalheLivroScreen(livroId: widget.livroId),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro: $e")),
        );
      }
    }
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF8D6748)),
      filled: true,
      fillColor: const Color(0xFFF5E9DA),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF8D6748)),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF8D6748), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      backgroundColor: const Color(0xFFEEE3D0), // Bege de fundo
      appBar: AppBar(
        title: const Text("Registrar Empréstimo"),
        backgroundColor: const Color(0xFF8D6748), // Marrom
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Icon(Icons.person, size: 60, color: Color(0xFF8D6748)),
              const SizedBox(height: 16),
              TextFormField(
                decoration: _decoration("Nome do Locatário"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _nomeLocatario = value!,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Empréstimo: ${dataFormat.format(_dataEmprestimo)}",
                      style: TextStyle(color: Color(0xFF8D6748)),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selecionarDataEmprestimo(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xFF8D6748),
                    ),
                    child: const Text("Selecionar Data"),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Devolução: ${dataFormat.format(_previsaoDevolucao)}",
                      style: TextStyle(color: Color(0xFF8D6748)),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selecionarPrevisaoDevolucao(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xFF8D6748),
                    ),
                    child: const Text("Selecionar Data"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8D6748), // Marrom
                    foregroundColor: const Color(0xFFF5E9DA), // Bege claro
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.save),
                  label: const Text("Confirmar Empréstimo", style: TextStyle(fontSize: 18)),
                  onPressed: _salvarEmprestimo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}