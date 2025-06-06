import 'package:flutter/material.dart';

class CadastroLivrosScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CadastroLivrosScreenState();
}

class _CadastroLivrosScreenState extends State<CadastroLivrosScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllerLivros = LivrosController();

  late String _titulo;
  late String _autor;
  late String _isbn;
  late String _ano;
  late String _editora;
  late String _genero;
  late String _tipo;
  late int _quantidade;
  String? _capa;

  _salvarLivros() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final novoLivros = Livros(
        titulo: _titulo,
        autor: _autor,
        isbn: _isbn,
        ano: _ano,
        editora: _editora,
        genero: _genero,
        tipo: _tipo,
        quantidadeDisponivel: _quantidade,
        capa: _capa,
      );
      await _controllerLivros.createLivros(novoLivros);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Novo Livros")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Título"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _titulo = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Autor"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _autor = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "ISBN"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _isbn = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Ano"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _ano = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Editora"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _editora = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Gênero"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _genero = value!,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: "Tipo"),
                items: ["Físico", "E-book"].map((tipo) {
                  return DropdownMenuItem(value: tipo, child: Text(tipo));
                }).toList(),
                onChanged: (value) => _tipo = value!,
                validator: (value) => value == null ? "Selecione o tipo" : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Quantidade disponível"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _quantidade = int.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "URL da capa (opcional)"),
                onSaved: (value) => _capa = value!.isEmpty ? null : value,
              ),
              SizedBox(height: 16),
              ElevatedButton(onPressed: _salvarLivros, child: Text("Cadastrar Livros")),
            ],
          ),
        ),
      ),
    );
  }
}
