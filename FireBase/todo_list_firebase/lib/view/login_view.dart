import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/view/registro_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //atributos
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  
  void _signIn() async{
    try {
      await auth.signInWithEmailAndPassword(
        email: _emailField.text, 
        password: _senhaField.text
       //Vericicar se o email e senha estão corretos pelo FireBase
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao autenticar usuario: $e"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text("login"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailField,
              decoration: InputDecoration(
                labelText: "Email"
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _senhaField,
              decoration: InputDecoration(
                labelText: "Senha"
              ),
              obscureText: true,
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _signIn, 
              child: Text("Login")),
            TextButton(
              onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context)=> RegistroView()) ),
              child: Text("Não tem uma conta? Registre-se Aqui"))
          ],
        ),
        ),
    );
  }
}