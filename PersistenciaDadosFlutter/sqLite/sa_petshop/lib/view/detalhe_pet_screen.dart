import 'package:flutter/material.dart';
import 'package:sa_petshop/controllers/consulta_controller.dart';
import 'package:sa_petshop/controllers/pet_controller.dart';
import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sa_petshop/models/pet_model.dart';
import 'package:sa_petshop/view/agenda_consulta_screen.dart';

class DetalhePetScreen extends StatefulWidget {
  final int petId; //receber petId -> atributo

  //construtor -> pegar Id do Pet
  const DetalhePetScreen({super.key, required this.petId});
  @override
  State<StatefulWidget> createState() {
    return _DetalhePetScreenState();
  }
}

class _DetalhePetScreenState extends State<DetalhePetScreen> {
  //build da Tela
  //atributos
  final PetController _petController = PetController();
  final ConsultaController _consultaController = ConsultaController();

  bool _isLoading = true;

  Pet? _pet; //pode ser inicialmente nulo

  List<Consulta> _consulta = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _carregarDados();
  }

  _carregarDados() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _pet = await _petController.readPetById(
        widget.petId,
      ); // vai carregar as informações do pet
      _consulta = await _consultaController.readConsultaForPet(
        widget.petId,
      ); // vai carregar a consulta do pet
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Exception: $e")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title:  Text("Detalhes do Pet"),),
      body: _isLoading
      ? Center(child: CircularProgressIndicator(),)
      : _pet==null //verifica se o pet foi encontrado
      ? Center(child:  Text("Erro ao carregar o pet."),)
      : Padding(padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nome: ${_pet!.nome}", style: TextStyle(fontSize: 20),),
          Text("Raça: ${_pet!.raca}"),
          Text("Dono: ${_pet!.nomeDono}"),
          Text("Telefone: ${_pet!.telefoneDono}"),
          Divider(),
          Text("Consultas:",style: TextStyle(fontSize: 20),),
                //operador Ternário par consultas
                _consulta.isEmpty
                ? Center(child:Text("Não Existe Agendamento para o Pet"),)
                : Expanded(child: ListView.builder(
                  itemCount: _consulta.length,
                  itemBuilder: (context,index){
                   final consulta = _consulta[index]; //elemento da lista
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text(consulta.tipoServico),
                          subtitle: Text(consulta.dataHoraFormatada),
                          trailing: IconButton(
                            onPressed: ()=>_deleteConsulta(consulta.id!),
                           icon: Icon(Icons.delete,color: Colors.red))
                        ),
                      );
                    }))
              ],
            ) 
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: ()=> Navigator.push(context,
               MaterialPageRoute(builder: (context)=>AgendaConsultaScreen(petId: widget.petId)))),
    );
  }

void _deleteConsulta(int consultaId) async{
   try {
      // deletar consulta
      await _consultaController.deleteConsulta(consultaId);
      // recarreegar a lista de consulta
      await _consultaController.readConsultaForPet(widget.petId);
      // mensagem para o usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Consulta Deletada com Sucesso"))
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e "))
      );
      
    }
  }

}