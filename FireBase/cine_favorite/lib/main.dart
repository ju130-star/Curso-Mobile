import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'view/login_view.dart';
import 'view/favorite_view.dart';
import 'view/registro_view.dart'; 


void main() async {
WidgetsFlutterBinding.ensureInitialized();
//inicializa o firebase

await Firebase.initializeApp(); //conecta o app ao firebase

  runApp(
    MaterialApp(
      title: "Cine Favorite",
      theme: ThemeData(
        primarySwatch: Colors.orange,
        brightness: Brightness.dark,
      ),
      home: AuthStream(),
    ),
  );
}

class AuthStream extends StatelessWidget {
  const AuthStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      //permite usuario null
      stream: FirebaseAuth.instance.authStateChanges(), //indentifica se o usuario esta logado ou n
      builder: (context, snapshot) {
        //se tiver usuario logado, vai para tela de favoritos
        if (snapshot.hasData) {
          // verifica se snapshot tem dados
          return FavoriteView();
        }
        return LoginView();
      },
    );
  }
}
