import 'package:bliblioteca_app/controllers/usuario_controller.dart';
import 'package:bliblioteca_app/models/usuario.dart';
import 'package:bliblioteca_app/views/usuario/usuario_form_view.dart';
import 'package:flutter/material.dart';

class UsuarioListView extends StatefulWidget {
  const UsuarioListView({super.key});

  @override
  State<UsuarioListView> createState() => _UsuarioListViewState();
}

class _UsuarioListViewState extends State<UsuarioListView> {
  //atributos
  final _controller = UsuarioController(); // chmar os controller
  List<Usuario> _usuarios = [];
  bool _loading = true;
  List<Usuario> _filtroUsuario = []; //lista para filtrar usuários por algum critério
  final _buscaField = TextEditingController(); //pegar o texto da busca

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    setState(() => _loading = true);
    try {
      _usuarios = await _controller.fetchAll();
      _filtroUsuario = _usuarios;
    } catch (e) {
      //tratar erro
    }
    setState(() => _loading = false);
  }

  void _filtrar() {
    final busca = _buscaField.text.toLowerCase();
    setState(() {
      _filtroUsuario = _usuarios.where((user) {
        return user.nome.toLowerCase().contains(busca) || //filtra pelo nome
        user.email.toLowerCase().contains(busca); //filtra pelo email
      }).toList(); //converte em lista
    });
  }

  void _openForm({Usuario? user}) async {
    // usuario entra no parametro, mas não é obrigatorio
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UsuarioFormView(user: user)),
    );
    _load();
  }

  void _delete(Usuario user) async {
    if (user.id == null) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirma Exclusão"),
        content: Text("Deseja Realmente Excluir o Usuário ${user.nome}"),
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
        await _controller.delete(user.id!);
        _load();
        // mensagem de confirmação
      } catch (e) {
        //tratar erro
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
                  decoration: InputDecoration(labelText: "Pesquisar Usuário"),
                  onChanged: (value) => _filtrar(),
                ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _usuarios.length,
                      itemBuilder: (context, index) {
                        final user = _usuarios[index];
                        return Card(
                          child: ListTile(
                            title: Text(user.nome),
                            subtitle: Text(user.email),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  //editar usuário existente
                                  onPressed: () => _openForm(user: user),
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () => _delete(user),
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
        onPressed: () => _openForm(), // abre o formulário sem levar o usuario
        child: Icon(Icons.add),
      ),
    );
  }
}
