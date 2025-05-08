import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => TelaInicial(),
        "/cadastro": (context) => TelaCadastro(),
      },
    ),
  );
}
