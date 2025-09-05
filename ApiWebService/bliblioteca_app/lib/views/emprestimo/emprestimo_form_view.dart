import 'package:bliblioteca_app/controllers/Emprestimo_controller.dart';
import 'package:bliblioteca_app/models/emprestimo.dart';
import 'package:flutter/material.dart';
import 'package:bliblioteca_app/views/emprestimo/emprestimo_list_view.dart'; // Adapte a importação

class EmprestimoFormView extends StatefulWidget {
  final Emprestimo? emprestimo;

  const EmprestimoFormView({super.key, this.emprestimo});

  @override
  State<EmprestimoFormView> createState() => _EmprestimoFormViewState();
}

class _EmprestimoFormViewState extends State<EmprestimoFormView> {
  final _formkey = GlobalKey<FormState>();
  final _controller = EmprestimoController();

  final _usuarioField = TextEditingController();
  final _livroField = TextEditingController();
  final _dataEmprestimoField = TextEditingController();
  final _dataDevolucaoField = TextEditingController();
  bool _devolvido = false;

  @override
  void initState() {
    super.initState();
    if (widget.emprestimo != null) {
      _usuarioField.text = widget.emprestimo!.usuario_id!;
      _livroField.text = widget.emprestimo!.livros_id!;
      _dataEmprestimoField.text = widget.emprestimo!.data_emprestimo;
      _dataDevolucaoField.text = widget.emprestimo!.data_devolucao!;
      _devolvido = widget.emprestimo!.devolvido!;
    }
  }

  void _save() async {
    if (_formkey.currentState!.validate()) {
      final emprestimo = Emprestimo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        usuario_id: _usuarioField.text.trim(),
        livros_id: _livroField.text.trim(),
        data_emprestimo: _dataEmprestimoField.text.trim(),
        data_devolucao: _dataDevolucaoField.text.trim(),
        devolvido: _devolvido,
      );
      try {
        await _controller.create(emprestimo);
      } catch (e) {
        // tratar erro
      }
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EmprestimoListView()),
      );
    }
  }

  void _update() async {
    if (_formkey.currentState!.validate()) {
      final emprestimo = Emprestimo(
        id: widget.emprestimo?.id,
        usuario_id: _usuarioField.text.trim(),
        livros_id: _livroField.text.trim(),
        data_emprestimo: _dataEmprestimoField.text.trim(),
        data_devolucao: _dataDevolucaoField.text.trim(),
        devolvido: _devolvido,
      );
      try {
        await _controller.update(emprestimo);
      } catch (e) {
        // tratar erro
      }
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EmprestimoListView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.emprestimo == null ? 'Novo Empréstimo' : 'Editar Empréstimo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _usuarioField,
                decoration: InputDecoration(labelText: 'Usuário'),
                validator: (value) => value!.isEmpty ? 'Usuário é obrigatório' : null,
              ),
              TextFormField(
                controller: _livroField,
                decoration: InputDecoration(labelText: 'Livro'),
                validator: (value) => value!.isEmpty ? 'Livro é obrigatório' : null,
              ),
              TextFormField(
                controller: _dataEmprestimoField,
                decoration: InputDecoration(labelText: 'Data Empréstimo'),
                validator: (value) => value!.isEmpty ? 'Data de empréstimo é obrigatória' : null,
              ),
              TextFormField(
                controller: _dataDevolucaoField,
                decoration: InputDecoration(labelText: 'Data Devolução'),
                validator: (value) => value!.isEmpty ? 'Data de devolução é obrigatória' : null,
              ),
              Row(
                children: [
                  Checkbox(
                    value: _devolvido,
                    onChanged: (value) {
                      setState(() {
                        _devolvido = value ?? false;
                      });
                    },
                  ),
                  Text('Devolvido'),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.emprestimo == null ? _save : _update,
                child: Text(widget.emprestimo == null ? 'Salvar' : 'Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
