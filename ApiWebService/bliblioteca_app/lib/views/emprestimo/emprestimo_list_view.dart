import 'package:bliblioteca_app/controllers/Emprestimo_controller.dart';
import 'package:bliblioteca_app/models/emprestimo.dart';
import 'package:bliblioteca_app/views/emprestimo/emprestimo_form_view.dart';
import 'package:flutter/material.dart';

class EmprestimoListView extends StatefulWidget {
  const EmprestimoListView({super.key});

  @override
  State<EmprestimoListView> createState() => _EmprestimoListViewState();
}

class _EmprestimoListViewState extends State<EmprestimoListView> {
  final _controller = EmprestimoController();
  List<Emprestimo> _emprestimos = [];
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
      _emprestimos = await _controller.fetchAll();
      _filtroEmprestimo = _emprestimos;
    } catch (e) {
      // tratar erro
    }
    setState(() => _loading = false);
  }

  void _filtrar() {
    final busca = _buscaField.text.toLowerCase();
    setState(() {
      _filtroEmprestimo = _emprestimos.where((emprestimo) {
        return emprestimo.usuario_id.toString().contains(busca) ||
            emprestimo.livros_id.toString().contains(busca) ||
            emprestimo.data_emprestimo.toString().contains(busca) ||
            emprestimo.data_devolucao.toString().contains(busca) ||
            (emprestimo.devolvido == true ? 'sim' : 'não').contains(busca);

      }).toList();
    });
  }

  void _delete(Emprestimo emprestimo) async {
    if (emprestimo.id == null) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirma Exclusão"),
        content: Text(
          "Deseja realmente excluir o Emprestimo '${emprestimo.usuario_id}'?",
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
        await _controller.delete(emprestimo.id!);
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
                        final emprestimo = _filtroEmprestimo[index];
                        return Card(
                          child: ListTile(
                            title: Text(emprestimo.usuario_id.toString()),
                          subtitle: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text("Livro: ${emprestimo.livros_id}"),
    Text("Empréstimo: ${emprestimo.data_emprestimo}"),
    Text("Devolução: ${emprestimo.data_devolucao}"),
    Text("Devolvido: ${emprestimo.devolvido ?? "Não"}"),
  ],
),

                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Adicione aqui o botão de editar se tiver formulário de Emprestimo
                                IconButton(
                                  onPressed: () => _delete(emprestimo),
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmprestimoFormView()),
    ).then((_) => _load()); // recarrega a lista depois que voltar do formulário
  },
  backgroundColor: Colors.blue[900], // fundo azul royal
  foregroundColor: Colors.white,     // ícone branco
  child: Icon(Icons.add),
),
    );
  }
}
