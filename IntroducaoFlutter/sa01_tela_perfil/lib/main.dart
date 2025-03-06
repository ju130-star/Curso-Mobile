import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuário'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ícone de perfil com nome abaixo
            ProfileIconWithName(),
            SizedBox(height: 20),
            // Adicionando três containers lado a lado
            ThreeContainersRow(),
            SizedBox(height: 20),
            
      
          ],
        ),
      ),
    );
  }
}

// Ícone de Perfil com Nome abaixo
class ProfileIconWithName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center( // Garante que todo o conteúdo da coluna será centralizado na tela
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente dentro do Column
        crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente dentro do Column
        children: <Widget>[
          // Ícone de perfil
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.person, color: Colors.white, size: 40),
          ),
          SizedBox(height: 20), // Aumenta o espaço entre o ícone e o nome
          // Nome abaixo do ícone, centralizado
          Text(
            'Julya Estrela',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// container
class ThreeContainersRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Espaço igual entre os containers
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 130, 176, 236),
            borderRadius: BorderRadius.circular(12), // Arredonda os cantos
          ),
          child: Center(
            child: Text('Container 1', textAlign: TextAlign.center),
          ),
        ),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 130, 176, 236),
            borderRadius: BorderRadius.circular(12), // Arredonda os cantos
          ),
          child: Center(
            child: Text('Container 2', textAlign: TextAlign.center),
          ),
        ),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 130, 176, 236),
            borderRadius: BorderRadius.circular(12), // Arredonda os cantos
          ),
          child: Center(
            child: Text('Container 3', textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }
}

class homepages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações Pessoais'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Linha 1 - Nome
            InformationRow(label: 'Nome:', value: 'Julya Estrela'),
            
            // Linha 2 - Idade
            InformationRow(label: 'Idade:', value: '17 anos'),
            
            // Linha 3 - Email
            InformationRow(label: 'Email:', value: 'julya@example.com'),
            
            // Linha 4 - Localização
            InformationRow(label: 'Localização:', value: 'Limeira, SP'),
          ],
        ),
      ),
    );
  }
}

// Widget para exibir uma linha de informação com label e value
class InformationRow extends StatelessWidget {
  final String label;
  final String value;

  const InformationRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          // Label (Nome, Idade, etc.)
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10), // Espaçamento entre label e value
          // Value (valor correspondente ao label)
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.right, // Alinha o value à direita
            ),
          ),
        ],
      ),
    );
  }
}



