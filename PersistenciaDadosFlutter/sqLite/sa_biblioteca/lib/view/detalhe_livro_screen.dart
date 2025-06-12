import 'package:flutter/material.dart';
import 'package:sa_biblioteca/controllers/emprestimo_controller.dart';
import 'package:sa_biblioteca/controllers/livros_controller.dart';
import 'package:sa_biblioteca/models/emprestimo_model.dart';
import 'package:sa_biblioteca/models/livros_model.dart';
import 'package:sa_biblioteca/view/cadastro_emprestimo_screen.dart';

class DetalheLivroScreen extends StatefulWidget {
  final int livroId;

  const DetalheLivroScreen({super.key, required this.livroId});

  @override
  State<DetalheLivroScreen> createState() => _DetalheLivroScreenState();
}

class _DetalheLivroScreenState extends State<DetalheLivroScreen> {
  final LivroController _livroController = LivroController();
  final EmprestimoController _emprestimoController = EmprestimoController();

  bool _isLoading = true;
  Livro? _livro;
  List<Emprestimo> _emprestimos = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _livro = await _livroController.readLivroById(widget.livroId);
      _emprestimos =
          await _emprestimoController.readEmprestimosForLivro(widget.livroId);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Erro ao carregar dados: $e")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteEmprestimo(int emprestimoId) async {
    try {
      await _emprestimoController.deleteEmprestimo(emprestimoId);
      await _carregarDados();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Empréstimo deletado com sucesso")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao deletar empréstimo: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEE3D0), // Bege de fundo
      appBar: AppBar(
        title: const Text("Detalhes do Livro"),
        backgroundColor: const Color(0xFF8D6748), // Marrom
        elevation: 2,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF8D6748)))
          : _livro == null
              ? const Center(child: Text("Erro ao carregar o livro."))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(Icons.menu_book, size: 60, color: Color(0xFF8D6748)),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _livro!.titulo,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8D6748),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _info("Autor", _livro!.autor),
                      _info("ISBN", _livro!.isbn),
                      _info("Ano", _livro!.ano.toString()),
                      _info("Editora", _livro!.editora),
                      _info("Gênero", _livro!.genero),
                      _info("Tipo", _livro!.tipo),
                      _info("Disponíveis", _livro!.quantidadeDisponivel.toString()),
                      if (_livro!.capa.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(_livro!.capa, height: 120, fit: BoxFit.cover, errorBuilder: (c, e, s) => SizedBox()),
                          ),
                        ),
                      const Divider(height: 32, color: Color(0xFF8D6748)),
                      const Text(
                        "Empréstimos:",
                        style: TextStyle(fontSize: 20, color: Color(0xFF8D6748), fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _emprestimos.isEmpty
                          ? const Center(child: Text("Nenhum empréstimo registrado.", style: TextStyle(color: Color(0xFF8D6748))))
                          : Expanded(
                              child: ListView.builder(
                                itemCount: _emprestimos.length,
                                itemBuilder: (context, index) {
                                  final emprestimo = _emprestimos[index];
                                  return Card(
                                    color: const Color(0xFFF5E9DA),
                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    child: ListTile(
                                      leading: const Icon(Icons.person, color: Color(0xFF8D6748)),
                                      title: Text(
                                        "Locatário: ${emprestimo.nomeLocatario}",
                                        style: const TextStyle(color: Color(0xFF8D6748), fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        emprestimo.dataEmprestimoFormatada,
                                        style: TextStyle(color: Colors.brown[400]),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _deleteEmprestimo(emprestimo.id!),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8D6748),
        child: const Icon(Icons.add, color: Color(0xFFF5E9DA)),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CadastroEmprestimoScreen(livroId: widget.livroId),
          ),
        ).then((_) => _carregarDados()),
        tooltip: "Adicionar Empréstimo",
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        "$label: $value",
        style: TextStyle(
          color: Colors.brown[700],
          fontSize: 16,
        ),
      ),
    );
  }
}