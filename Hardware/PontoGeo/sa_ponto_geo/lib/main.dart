import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'views/login_view.dart';
 // gerado pelo FlutterFire CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // importante
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ponto Geo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginView(), // primeira tela
    );
  }
}
