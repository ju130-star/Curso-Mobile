import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/view/login_view.dart';
import 'package:todo_list_firebase/view/tarefas_view.dart';

//Tela de autenticação de usuario já cadastrado(login/cadastro)
class AuthView extends StatefulWidget {

  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>( //indentidificar o usuario instatantaneamente
      //verifica se o usuario está logado ou não
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //se o usuario estiver logado
        if(snapshot.hasData){ //se tiver dados vai para a tarefa se não vai para login 
          return TarefasView();
        }
        return LoginView();
      },
    );
  }
}