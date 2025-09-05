import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  //atributos
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _confirmaSenhaField = TextEditingController();
  
  void _registrar() async{
    if(_senhaField.text != _confirmarSenhaField.text) return;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailField.text.trim(), 
        password: _senhaField.text);
      // após o registro , u usuário já é logado no sistema 
      // AuthView -> Joga ele pra tela de Tarefas
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao registrar usuario: $e"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro"),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailField,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _senhaField,
              decoration: InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            TextField(
              controller: _confirmaSenhaField,
              decoration: InputDecoration(labelText: "Confirme a Senha"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _senhaField.text != _confirmaSenhaField.text
            ? Text("Senhas não conferem!", style: TextStyle(color: Colors.red, fontSize: 12,))
            : ElevatedButton(onPressed: _registrar, child: Text("Registrar")),
            TextButton(onPressed: () => Navigator.pop, child: Text("Voltar"))
          ],
        ),
      ),
    );
  }
}