import 'package:bliblioteca_app/controllers/livro_controller.dart';
import 'package:bliblioteca_app/models/livros.dart';
import 'package:flutter/material.dart';
import 'package:bliblioteca_app/views/livro/livro_list_view.dart'; // Adicione este import

class LivroFormView extends StatefulWidget {
  final Livro? livro;

  const LivroFormView({super.key, this.livro});

  @override
  State<LivroFormView> createState() => _LivroFormViewState();
}

class _LivroFormViewState extends State<LivroFormView> {
  final _formkey = GlobalKey<FormState>();
  final _controller = LivroController();
  final _tituloField = TextEditingController();
  final _autorField = TextEditingController();
  bool _disponivel = true;

  @override
  void initState() {
    super.initState();
    if (widget.livro != null) {
      _tituloField.text = widget.livro!.titulo;
      _autorField.text = widget.livro!.autor;
    }
  }

  void _save() async {
    if (_formkey.currentState!.validate()) {
      final livro = Livro(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // corrigido
        titulo: _tituloField.text.trim(),
        autor: _autorField.text.trim(),
        disponivel: _disponivel,
      );
      try {
        await _controller.create(livro);
      } catch (e) {
        // tratar erro
      }
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LivroListView()),
      );
    }
  }

  void _update() async {
    if (_formkey.currentState!.validate()) {
      final livro = Livro(
        id: widget.livro?.id!,
        titulo: _tituloField.text.trim(),
        autor: _autorField.text.trim(),
        disponivel: _disponivel,
      );
      try {
        await _controller.update(livro);
      } catch (e) {
        // tratar erro
      }
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LivroListView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.livro == null ? 'Novo Livro' : 'Editar Livro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloField,
                decoration: InputDecoration(labelText: 'titulo'),
                validator: (value) => value!.isEmpty ? 'titulo é obrigatório' : null,
              ),
              TextFormField(
                controller: _autorField,
                decoration: InputDecoration(labelText: 'autor'),
                validator: (value) => value!.isEmpty ? 'autor é obrigatório' : null,
              ),
              Row(
                children: [
                  Checkbox(
                    value: _disponivel,
                    onChanged: (value) {
                      setState(() {
                        _disponivel = value ?? true;
                      });
                    },
                  ),
                  Text('Disponível'),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.livro == null ? _save : _update,
                child: Text(widget.livro == null ? 'Salvar' : 'Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}