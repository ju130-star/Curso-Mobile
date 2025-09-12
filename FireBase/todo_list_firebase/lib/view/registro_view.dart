import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  //atributos
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _confirmarSenhaField = TextEditingController();
  bool _ocultarSenha = true;
  bool _ocultarConfirmarSenha = true;

  //método para registrar novo usuário
  void _registrar() async{
    if(_senhaField.text != _confirmarSenhaField.text) return;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailField.text.trim(), 
        password: _senhaField.text);
      // após o registro , u usuário já é logado no sistema 
      // AuthView -> Joga ele pra tela de Tarefas
      Navigator.pop(context); //volta para tela de login
    } on FirebaseAuthException catch (e) { //erro especificos do FirebaseAuth
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao Registrar: $e"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailField,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(// adicionar o olho de ver senha
              controller: _senhaField,
              decoration: InputDecoration(
                labelText: "Senha",
                suffix: IconButton(
                  icon: Icon(_ocultarSenha ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() {
                      _ocultarSenha = !_ocultarSenha;
                    })),
                    
              ),
              obscureText: _ocultarSenha,
            ),
            TextField(
              controller: _confirmarSenhaField,
              decoration: InputDecoration(
                labelText: "Confirmar Senha",
                suffix: IconButton(
                  icon: Icon(_ocultarConfirmarSenha ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() {
                      _ocultarConfirmarSenha = !_ocultarConfirmarSenha;
                    })),
                    
              ),
              obscureText: _ocultarConfirmarSenha,
            ),
            SizedBox(height: 20,),
            _senhaField.text != _confirmarSenhaField.text 
            ? Text("As senhas devem ser Iguais", 
              style: TextStyle(color: Colors.red, ), )
            : ElevatedButton(onPressed: _registrar, child: Text("Registrar")),
            TextButton(onPressed: () => Navigator.pop, child: Text("Voltar"))
          ],
        ),),
    );
  }
}