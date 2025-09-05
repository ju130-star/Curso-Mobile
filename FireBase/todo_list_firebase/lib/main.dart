
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/firebase_options.dart';
import 'package:todo_list_firebase/view/auth_view.dart';

void main() async{ // sincronizza com o firebase enquanto compila a build do aplicativo
  //garantir a inicialização dos binding
  WidgetsFlutterBinding.ensureInitialized();
  //inicializar o firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MaterialApp(
    title: "lista de tarefas",
    home: AuthView(),
    debugShowCheckedModeBanner: false,
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "lista de tarefas",
      home: AuthView(),
      debugShowCheckedModeBanner: false,
      
    );
  }
}