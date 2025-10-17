import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sa_ponto_geo/views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // conecta ao Firebase
  runApp(MaterialApp(
    home: const LoginView(),
    debugShowCheckedModeBanner: false,
  ));
}
