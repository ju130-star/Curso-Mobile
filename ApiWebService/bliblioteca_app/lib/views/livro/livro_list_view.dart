import 'package:bliblioteca_app/controllers/livro_controller.dart';
import 'package:bliblioteca_app/models/livros.dart';
import 'package:flutter/material.dart';

class LivroListView extends StatefulWidget {
  const LivroListView({super.key});

  @override
  State<LivroListView> createState() => _LivroListViewState();
}

class _LivroListViewState extends State<LivroListView> {
  final _controller = LivroController();
  List<Livro> _livros = [];
  bool _loading = true;
  List<Livro> _filtroLivro = [];
  final _buscaField = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    setState(() => _loading = true);
    try {
      _livros = await _controller.fetchAll();
      _filtroLivro = _livros;
    } catch (e) {
      // tratar erro
    }
    setState(() => _loading = false);
  }

  void _filtrar() {
    final busca = _buscaField.text.toLowerCase();
    setState(() {
      _filtroLivro = _livros.where((livro) {
        return livro.titulo.toLowerCase().contains(busca) ||
            livro.autor.toLowerCase().contains(busca);
      }).toList();
    });
  }

  void _delete(Livro livro) async {
    if (livro.id == null) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirma Exclusão"),
        content: Text("Deseja realmente excluir o livro '${livro.titulo}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Excluir"),
          ),
        ],
      ),
    );
    if (confirm == true) {
      try {
        await _controller.delete(livro.id!);
        _load();
      } catch (e) {
        // tratar erro
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _buscaField,
                    decoration: InputDecoration(labelText: "Pesquisar Livro"),
                    onChanged: (value) => _filtrar(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filtroLivro.length,
                      itemBuilder: (context, index) {
                        final livro = _filtroLivro[index];
                        return Card(
                          child: ListTile(
                            title: Text(livro.titulo),
                            subtitle: Text(livro.autor),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Adicione aqui o botão de editar se tiver formulário de livro
                                IconButton(
                                  onPressed: () => _delete(livro),
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
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
        onPressed: () {
          // Adicione aqui a navegação para o formulário de livro se existir
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
