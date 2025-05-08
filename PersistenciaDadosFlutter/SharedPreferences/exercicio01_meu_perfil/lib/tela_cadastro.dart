import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaCadastros extends StatefulWidget {
  @override
  State<TelaCadastros> createState() => _TelaCadastrosState();
}

class _TelaCadastrosState extends State<TelaCadastros> {
  //atributos
  String _nome = "";
  bool _logado = false;
  List<String> _cadastros = [];
  TextEditingController _cadastroController = TextEditingController();


  //métodos
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _carregarPreferencias();
  }

  _carregarPreferencias() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = _prefs.getString("nome") ?? "";
      _logado = _prefs.getBool("logado") ?? false;
      _cadastros = _prefs.getStringList(_nome) ?? [];
    });
    if (_logado) {
      Navigator.pushNamed(context, "/");
    }
  }

  //build
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    child: Scaffold(
        appBar: AppBar(
          title: Text("Preferencias de $_nome"),
          actions: [
            IconButton(
              onPressed: () async {
                SharedPreferences _prefs =
                    await SharedPreferences.getInstance();
                _logado = false;
                _prefs.setBool("logado", _logado);
                _prefs.setString("nome", "");
                Navigator.pushNamed(context, "/");
              },
               ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _cadastroController,
                decoration: InputDecoration(labelText: "Insira seu nome"),
              ),
              TextField(
                controller: _cadastroController,
                decoration: InputDecoration(labelText: "Insira sua idade"),
              ),
              TextField(
                controller: _cadastroController,
                decoration: InputDecoration(labelText: "Insira sua cor favorita"),
              ),
         
              ElevatedButton(
                onPressed: _adicionarCadastro,
                child: Text("Adicionar Tarefa"),
              ),