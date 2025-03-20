import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: ListaTarefas()));
}

class ListaTarefas extends StatefulWidget {
  @override
  _ListaTarefasState createState() => _ListaTarefasState();
}

class _ListaTarefasState extends State<ListaTarefas> {
  final TextEditingController _tarefaController = TextEditingController();
  List<Map<String, dynamic>> _tarefas = [];

  void _adicionarTarefas() {}

  void _removerTarefas() {}

  //construiir estrutura de widget
 @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Lista de Tarefas"),),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _tarefaController,
            decoration: InputDecoration(labelText: "Digite uma Tarefa"),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: _adicionarTarefas, 
            child: Text("Adicionar Tarefa")),
          Expanded(child: child)
        ],
      ),),
  );

  
}
