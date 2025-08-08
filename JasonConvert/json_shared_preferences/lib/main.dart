import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool temaEscuro = false;
  String nomeUsuario = "";

  @override
  void initState(); {
  carregarPreferencias();
  }
}

 void carregarPreferencias() async{
   // Carregar preferências do usuário
 final prefs = await SharedPreferences.getInstance();
    //recupera as informaçõeos do sharedPref e armazena como String (Json)
    String? jsonString = prefs.getString('config');
    if(jsonString != null){
      // Transformo Json em MAP - decode
      Map<String,dynamic> config = json.decode(jsonString);
      setState(() {
        // pea as informaç~eos de acordo com a chave armazenada
        temaEscuro = config['temaEscuro'] ?? false;
        nomeUsuario = config['nome'] ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App de configurações",
      //operador ternário
      theme: temaEscuro ? ThemeData.dark() : ThemeData.light(),
      home: ConfigPage()
    );
  }


}