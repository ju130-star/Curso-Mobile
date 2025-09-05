import 'package:bliblioteca_app/views/livro/livro_form_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bliblioteca_app/views/home_view.dart'; // Adicione este import

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Biblioteca App',
    home: HomeView(),
    theme: ThemeData(
  primaryColor: Colors.blue[900], // azul royal
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue[900], // AppBar azul royal
    foregroundColor: Colors.white,     // título branco
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue[900], // FAB azul royal
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue[900], // Botões elevados azul royal
      foregroundColor: Colors.white,    // texto branco
    ),
  ),
),
  ));
}