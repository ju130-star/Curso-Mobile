//formulario de Cadastro do Pet

import 'package:flutter/material.dart';
import 'package:sa_petshop/controllers/pet_controller.dart';
import 'package:sa_petshop/models/pet_model.dart';
import 'package:sa_petshop/view/home_screen.dart';

class CadastroPetScreen extends StatefulWidget {
  // tela dinamica - mudanças de estado depois da contrução inicial
  @override
  State<StatefulWidget> createState() => _CadastroPetScreenState(); //chama a mudança
}

class _CadastroPetScreenState extends State<CadastroPetScreen> {
  //faz a build da tela
  //atributos

  final _formKey = GlobalKey<FormState>(); //chave para armazenamento
  final _controllerPet = PetController();

  // atributos do obj
  //late = permite mais de uma mudança por isso não usamos final
  late String _nome;
  late String _raca;
  late String _nomeDono;
  late String _telefoneDono;

  //Cadastrar po Pet (salvar no BD)
 _salvarPet() async {
    //future = uma função asincrona, vai me retornar no futuro
    if (_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      final newPet = Pet(
        nome: _nome,
        raca: _raca,
        nomeDono: _nomeDono,
        telefoneDono: _telefoneDono);
      //mandar informações para BD
      await _controllerPet.createPet(newPet);
      //volta para a tela inicial
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Novo Pet"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nome do Pet"),
                validator: (value)=> value!.isEmpty ? "Campo não Preenchido!!!": null,
                onSaved: (value) => _nome= value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Raça do Pet"),
                validator: (value)=> value!.isEmpty ? "Campo não Preenchido!!!": null,
                onSaved: (value) => _raca= value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Dono do Pet"),
                validator: (value)=> value!.isEmpty ? "Campo não Preenchido!!!": null,
                onSaved: (value) => _nomeDono= value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Telefone Dono do Pet"),
                validator: (value)=> value!.isEmpty ? "Campo não Preenchido!!!": null,
                onSaved: (value) => _telefoneDono= value!,
              ),
               ElevatedButton(onPressed: _salvarPet, child: Text("Cadastrar Pet"))
            ],
            
          )
          ),
        ),
    );
  }
}
