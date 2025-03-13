import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Scaffold(
      appBar: AppBar(title: Text("Exemplo Widget Exibição"),),
      body: Center(
        child: Column(
          children: [
            Text("Texto de Exemplo",style: TextStyle(
              fontSize: 20,
              color: Colors.amber
            ),),
            Text("Flutter é incrível",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                letterSpacing: 2
              ),
              textAlign:TextAlign.right,),
              Image.network('https://storage.googleapis.com/cms-storage-bucket/9abb63d8732b978c7ea1.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,),
              Image.asset("assets/img/einstein.jpg",
              width: 400,
              height: 400,
              fit: BoxFit.cover,),
              Icon(Icons.star,
              size: 30,
              color: Colors.pink,
              ),
           ],
        ),
      )
       ),
    );
  }
}
