import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Função principal que inicia o app com o widget raiz.
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, 
    home: PerfilPage(),
  ));
}

// Widget de estado dinâmico (StatefulWidget)
class PerfilPage extends StatefulWidget {
  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  // Controladores para entrada de texto
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _idadeController = TextEditingController();

  // Variáveis para armazenar os dados do usuário
  String? _nome;
  String? _idade;
  String? _cor;

  // Cor de fundo inicial
  Color _corFundo = Colors.white;

  // Mapa de cores disponíveis
  Map<String, Color> coresDisponiveis = {
    "Azul": Colors.blue,
    "Verde": Colors.green,
    "Vermelho": Colors.red,
    "Amarelo": Colors.yellow,
    "Cinza": Colors.grey,
    "Preto": Colors.black,
    "Branco": Colors.white,
    "Rosa": Colors.pink,
  };

  // Método que é chamado ao iniciar o widget
  @override
  void initState() {
    super.initState();
    _carregarPreferencias();
  }

  // Carrega os dados salvos na memória local
  _carregarPreferencias() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = _prefs.getString("nome");
      _idade = _prefs.getString("idade");
      _cor = _prefs.getString("cor");
      if (_cor != null) {
        _corFundo = coresDisponiveis[_cor!]!;
      }
    });
  }

  // Salva os dados inseridos pelo usuário na memória local
  _salvarPreferencias() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _nome = _nomeController.text.trim();
    _idade = _idadeController.text.trim();
    _corFundo = coresDisponiveis[_cor!]!;
    await _prefs.setString("nome", _nome ?? "");
    await _prefs.setString("idade", _idade ?? "");
    await _prefs.setString("cor", _cor ?? "Branco");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _corFundo,
      appBar: AppBar(
        title: Text(
          "Meu Perfil",
          style: TextStyle(
              color: _cor == "Branco" ? Colors.black : Colors.white),
        ),
        backgroundColor: _corFundo,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            // Campo para nome
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            // Campo para idade
            TextField(
              controller: _idadeController,
              decoration: InputDecoration(labelText: "Idade"),
            ),
            SizedBox(height: 16),
            // Dropdown para selecionar cor favorita
            DropdownButtonFormField(
              value: _cor,
              decoration: InputDecoration(labelText: "Cor Favorita"),
              items: coresDisponiveis.keys.map((cor) {
                return DropdownMenuItem(
                  value: cor,
                  child: Text(cor),
                );
              }).toList(),
              onChanged: (valor) {
                setState(() {
                  _cor = valor;
                });
              },
            ),
            SizedBox(height: 16),
            // Botão de salvar
            ElevatedButton(
              onPressed: _salvarPreferencias,
              child: Text("Salvar Perfil"),
            ),
            SizedBox(height: 16),
            Divider(),
            Text("Dados do Usuário:"),
            // Exibe os dados salvos se existirem
            if (_nome != null)
              Text(
                "Nome: $_nome",
                style: TextStyle(
                    color:
                        _cor == "Branco" ? Colors.black : Colors.white),
              ),
            if (_idade != null)
              Text(
                "Idade: $_idade",
                style: TextStyle(
                    color:
                        _cor == "Branco" ? Colors.black : Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
