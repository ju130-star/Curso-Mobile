import 'package:bliblioteca_app/controllers/Emprestimo_controller.dart';
import 'package:bliblioteca_app/models/emprestimo.dart';
import 'package:flutter/material.dart';

class EmprestimoListView extends StatefulWidget {
  const EmprestimoListView({super.key});

  @override
  State<EmprestimoListView> createState() => _EmprestimoListViewState();
}

class _EmprestimoListViewState extends State<EmprestimoListView> {
  final _controller = EmprestimoController();
  List<Emprestimo> _Emprestimos = [];
  bool _loading = true;
  List<Emprestimo> _filtroEmprestimo = [];
  final _buscaField = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    setState(() => _loading = true);
    try {
      _Emprestimos = await _controller.fetchAll();
      _filtroEmprestimo = _Emprestimos;
    } catch (e) {
      // tratar erro
    }
    setState(() => _loading = false);
  }

  void _filtrar() {
    final busca = _buscaField.text.toLowerCase();
    setState(() {
      _filtroEmprestimo = _Emprestimos.where((Emprestimo) {
        return Emprestimo.usuario_id.toLowerCase().contains(busca) ||
            Emprestimo.livros_id.toLowerCase().contains(busca) ||
            Emprestimo.data_emprestimo.toLowerCase().contains(busca) ||
            Emprestimo.data_devolucao.toLowerCase().contains(busca) ||
            Emprestimo.devolvido?.toLowerCase() ?? ''.contains(busca);
      }).toList();
    });
  }

  void _delete(Emprestimo Emprestimo) async {
    if (Emprestimo.id == null) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirma Exclusão"),
        content: Text(
          "Deseja realmente excluir o Emprestimo '${Emprestimo.usuario_id}'?",
        ),
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
        await _controller.delete(Emprestimo.id!);
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
                    decoration: InputDecoration(
                      labelText: "Pesquisar Emprestimo",
                    ),
                    onChanged: (value) => _filtrar(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filtroEmprestimo.length,
                      itemBuilder: (context, index) {
                        final Emprestimo = _filtroEmprestimo[index];
                        return Card(
                          child: ListTile(
                            title: Text(Emprestimo.usuario_id),
                            subtitle: Text(Emprestimo.livros_id),
                            subtitle: Text(
                              DateTime.parse(
                                Emprestimo.data_emprestimo,
                              ).toLocal().toString(),
                            ),
                            subtitle: Text(
                              DateTime.parse(
                                Emprestimo.data_devolucao,
                              ).toLocal().toString(),
                            ),
                            subtitle: Text(Emprestimo.devolvido),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Adicione aqui o botão de editar se tiver formulário de Emprestimo
                                IconButton(
                                  onPressed: () => _delete(Emprestimo),
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
          // Adicione aqui a navegação para o formulário de Emprestimo se existir
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
