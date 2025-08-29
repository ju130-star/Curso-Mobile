import 'package:bliblioteca_app/controllers/usuario_controller.dart';
import 'package:bliblioteca_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:bliblioteca_app/views/usuario/usuario_list_view.dart'; // Adicione este import

class UsuarioFormView extends StatefulWidget {
  final Usuario? user;

  const UsuarioFormView({super.key, this.user});

  @override
  State<UsuarioFormView> createState() => _UsuarioFormViewState();
}

class _UsuarioFormViewState extends State<UsuarioFormView> {
  final _formkey = GlobalKey<FormState>();
  final _controller = UsuarioController();
  final _nomeField = TextEditingController();
  final _emailField = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nomeField.text = widget.user!.nome;
      _emailField.text = widget.user!.email;
    }
  }

  void _save() async {
    if (_formkey.currentState!.validate()) {
      final user = Usuario(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // corrigido
        nome: _nomeField.text.trim(),
        email: _emailField.text.trim(),
      );
      try {
        await _controller.create(user);
      } catch (e) {
        // tratar erro
      }
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UsuarioListView()),
      );
    }
  }

  void _update() async {
    if (_formkey.currentState!.validate()) {
      final user = Usuario(
        id: widget.user?.id!,
        nome: _nomeField.text.trim(),
        email: _emailField.text.trim(),
      );
      try {
        await _controller.update(user);
      } catch (e) {
        // tratar erro
      }
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UsuarioListView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Novo Usuário' : 'Editar Usuário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeField,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? 'Nome é obrigatório' : null,
              ),
              TextFormField(
                controller: _emailField,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Email é obrigatório' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.user == null ? _save : _update,
                child: Text(widget.user == null ? 'Salvar' : 'Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}