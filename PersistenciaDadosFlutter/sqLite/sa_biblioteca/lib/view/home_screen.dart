import 'package:flutter/material.dart';
import 'package:sa_biblioteca/controllers/livros_controller.dart';
import 'package:sa_biblioteca/view/cadastro_livro_screen.dart';
import 'package:sa_biblioteca/view/detalhe_livro_screen.dart';
import '../models/livros_model.dart';

// Adicione este widget decorado no mesmo arquivo ou crie em lib/widgets/livro_card.dart
class LivroCard extends StatelessWidget {
  final Livro livro;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const LivroCard({
    Key? key,
    required this.livro,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF5E9DA), // Bege claro
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          livro.tipo == 'físico' ? Icons.menu_book : Icons.menu_book_outlined,
          size: 40,
          color: const Color(0xFF8D6748), // Marrom
        ),
        title: Text(
          livro.titulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF8D6748), // Marrom
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Autor: ${livro.autor}', style: TextStyle(color: Colors.brown[700])),
            Text('ISBN: ${livro.isbn}', style: TextStyle(color: Colors.brown[400])),
            Text('Ano: ${livro.ano} | Editora: ${livro.editora}', style: TextStyle(color: Colors.brown[400])),
            Text('Gênero: ${livro.genero}', style: TextStyle(color: Colors.brown[400])),
            Text('Disponível: ${livro.quantidadeDisponivel}', style: TextStyle(color: Colors.brown[400])),
            Text('Capa: ${livro.capa}', style: TextStyle(color: Colors.brown[400])),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFF8D6748)),
        onTap: onTap,
        onLongPress: onLongPress,
        isThreeLine: true,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final LivroController _controllerLivro = LivroController();
  List<Livro> _livros = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    setState(() {
      _isLoading = true;
    });
    _livros = [];
    try {
      _livros = await _controllerLivro.readLivros();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao carregar os dados: $e")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEE3D0), // Bege de fundo
      appBar: AppBar(
        title: const Text("Meus Livros"),
        backgroundColor: const Color(0xFF8D6748), // Marrom
        elevation: 2,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF8D6748)))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: _livros.isEmpty
                  ? const Center(child: Text("Nenhum livro cadastrado.", style: TextStyle(color: Color(0xFF8D6748))))
                  : ListView.builder(
                      itemCount: _livros.length,
                      itemBuilder: (context, index) {
                        final livro = _livros[index];
                        return LivroCard(
                          livro: livro,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetalheLivroScreen(livroId: livro.id!),
                            ),
                          ),
                          onLongPress: () => _deleteLivro(livro.id!),
                        );
                      },
                    ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8D6748), // Marrom
        child: const Icon(Icons.book, color: Color(0xFFF5E9DA)), // Bege claro
        onPressed: () async {
          final resultado = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroLivrosScreen()),
          );
          if (resultado == true) {
            _carregarDados(); // recarrega lista se um livro foi cadastrado
          }
        },
      ),
    );
  }

  void _deleteLivro(int id) async {
    try {
      await _controllerLivro.deleteLivro(id);
      _carregarDados(); // Atualiza a lista após deletar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Livro deletado com sucesso")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao deletar livro: $e")),
      );
    }
  }
}