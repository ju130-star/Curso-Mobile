import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TarefasView extends StatefulWidget {
  const TarefasView({super.key});

  @override
  State<TarefasView> createState() => _TarefasViewState();
}

class _TarefasViewState extends State<TarefasView> {
  // Atributos
  final _db = FirebaseFirestore.instance; // Controle do banco (salvar ou recuperar da nuvem)
  final User? _user = FirebaseAuth.instance.currentUser; // Pegar o usuário logado
  final _tarefaField = TextEditingController(); // Pegar o título da tarefa

  // Método para adicionar nova tarefa
  void _addTarefa() async {
    if (_tarefaField.text.trim().isEmpty) return; // Não continua se o campo estiver vazio

    try {
      await _db.collection("usuarios")
          .doc(_user!.uid) // Pegar o documento do usuário logado
          .collection("tarefas") // Pegar a coleção de tarefas
          .add({ // Adicionar uma nova tarefa
        "titulo": _tarefaField.text.trim(),
        "dataCriacao": Timestamp.now(), // Carimbo de data e hora
        "concluida": false, // Inicialmente não concluída
      });

      _tarefaField.clear(); // Limpa o campo de texto após adicionar
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao adicionar tarefa: $e")),
      );
    }
  }

  // Método para atualizar o status de conclusão da tarefa
  void _atualizarTarefa(String tarefaId, bool concluida) async {
    await _db.collection("usuarios")
        .doc(_user!.uid)
        .collection("tarefas")
        .doc(tarefaId)
        .update({"concluida": concluida});
  }

  // Método para remover uma tarefa
  void _deletarTarefa(String tarefaId) async {
    await _db.collection("usuarios")
        .doc(_user!.uid)
        .collection("tarefas")
        .doc(tarefaId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut(); // Logout do usuário
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Campo de texto para nova tarefa
            TextField(
              controller: _tarefaField,
              decoration: InputDecoration(
                labelText: "Nova Tarefa",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTarefa, // Chama função para adicionar tarefa
                ),
              ),
            ),
            SizedBox(height: 16),
            // Lista de tarefas
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _db
                    .collection("usuarios")
                    .doc(_user?.uid)
                    .collection("tarefas")
                    .orderBy("dataCriacao", descending: true)
                    .snapshots(), // Escuta mudanças na coleção
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator()); // Loader enquanto carrega
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("Nenhuma Tarefa Encontrada"));
                  }

                  final tarefas = snapshot.data!.docs; // Lista de documentos

                  return ListView.builder(
                    itemCount: tarefas.length,
                    itemBuilder: (context, index) {
                      final tarefa = tarefas[index];
                      final tarefaMap = tarefa.data() as Map<String, dynamic>;
                      final concluida = tarefaMap["concluida"] ?? false; // Boolean para checkbox

                      return ListTile(
                        title: Text(
                          tarefaMap["titulo"], // Título da tarefa
                          style: concluida
                              ? TextStyle(
                                  decoration: TextDecoration.lineThrough, // Riscado se concluída
                                  color: Colors.grey,
                                )
                              : null,
                        ),
                        leading: Checkbox(
                          value: concluida,
                          onChanged: (value) {
                            _atualizarTarefa(tarefa.id, value ?? false); // Atualiza status no Firestore
                          },
                        ),
                        trailing: IconButton(
                          onPressed: () => _deletarTarefa(tarefa.id), // Remove tarefa
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
