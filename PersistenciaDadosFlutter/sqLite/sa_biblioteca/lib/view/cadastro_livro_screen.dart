import 'package:flutter/material.dart';
import 'package:sa_biblioteca/controllers/livros_controller.dart';
import 'package:sa_biblioteca/models/livros_model.dart';
import 'package:sa_biblioteca/view/home_screen.dart';

class CadastroLivrosScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CadastroLivrosScreenState();
}

class _CadastroLivrosScreenState extends State<CadastroLivrosScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllerLivros = LivroController();

  late String _titulo;
  late String _autor;
  late String _isbn;
  late int _ano;
  late String _editora;
  late String _genero;
  late String _tipo;
  late int _quantidade;
  String? _capa;

  _salvarLivros() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final novoLivros = Livro(
        titulo: _titulo,
        autor: _autor,
        isbn: _isbn,
        ano: (_ano),
        editora: _editora,
        genero: _genero,
        tipo: _tipo,
        quantidadeDisponivel: _quantidade,
        capa: _capa ?? '',
      );
      await _controllerLivros.createLivro(novoLivros);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEE3D0), // Bege de fundo
      appBar: AppBar(
        title: const Text("Novo Livro"),
        backgroundColor: const Color(0xFF8D6748), // Marrom
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Icon(Icons.menu_book, size: 60, color: Color(0xFF8D6748)),
              const SizedBox(height: 16),
              _buildCampo("Título", onSaved: (v) => _titulo = v!),
              _buildCampo("Autor", onSaved: (v) => _autor = v!),
              _buildCampo("ISBN", onSaved: (v) => _isbn = v!),
              _buildCampo("Ano", tipo: TextInputType.number, onSaved: (v) => _ano = int.parse(v!)),
              _buildCampo("Editora", onSaved: (v) => _editora = v!),
              _buildCampo("Gênero", onSaved: (v) => _genero = v!),
              DropdownButtonFormField<String>(
                decoration: _decoration("Tipo"),
                items: ["Físico", "E-book"].map((tipo) {
                  return DropdownMenuItem(value: tipo, child: Text(tipo));
                }).toList(),
                onChanged: (value) => _tipo = value!,
                validator: (value) => value == null ? "Selecione o tipo" : null,
              ),
              _buildCampo("Quantidade disponível", tipo: TextInputType.number, onSaved: (v) => _quantidade = int.parse(v!)),
              _buildCampo("URL da capa (opcional)", obrigatorio: false, onSaved: (v) => _capa = v!.isEmpty ? null : v),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8D6748), // Marrom
                    foregroundColor: const Color(0xFFF5E9DA), // Bege claro
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.save),
                  label: const Text("Cadastrar Livro", style: TextStyle(fontSize: 18)),
                  onPressed: _salvarLivros,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF8D6748)),
      filled: true,
      fillColor: const Color(0xFFF5E9DA),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF8D6748)),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF8D6748), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildCampo(String label,
      {TextInputType tipo = TextInputType.text, bool obrigatorio = true, required FormFieldSetter<String> onSaved}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        decoration: _decoration(label),
        keyboardType: tipo,
        validator: obrigatorio ? (value) => value!.isEmpty ? "Campo obrigatório" : null : null,
        onSaved: onSaved,
      ),
    );
  }
}