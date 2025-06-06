import 'package:flutter/material.dart';
import 'package:sa_petshop/view/cadastro_pet_screen.dart';
import 'package:sa_petshop/view/detalhe_pet_screen.dart';

import '../controllers/pet_controller.dart';
import '../models/pet_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final PetController _controllerPet = PetController();
  List<Pet> _pets = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    setState(() {
      _isLoading = true;
    });
    _pets = [];
    try {
      _pets = await _controllerPet.readPets();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao Carregar os Dados $e")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // build da tela
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Meus Pets"),),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(),)
          : Padding(
              padding: EdgeInsets.all(16),
              child: Expanded(
                child: ListView.builder(
                  itemCount: _pets.length,
                  itemBuilder: (context, index) {
                    final pet = _pets[index];
                    return ListTile(
                      title: Text("${pet.nome} - ${pet.raca}"),
                      subtitle: Text("${pet.nomeDono} - ${pet.telefoneDono}"),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>DetalhePetScreen(petId: pet.id!))), //página de detalhes dp pet
                       onLongPress: () => _deletePet(pet.id!),  
                  );
                  }),
              ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder:
            (context)=> CadastroPetScreen())),
            tooltip: "Adicionar Novo Pet",
            child: Icon(Icons.add),
          ),
    );
  }

  void _deletePet(int id) async {
    try {
      await _controllerPet.deletePet(id);
      await _controllerPet.readPets();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pet Deletado com Sucesso"))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e"))
      );
      
    }
  }
}