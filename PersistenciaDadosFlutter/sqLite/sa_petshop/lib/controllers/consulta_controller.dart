import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sa_petshop/services/patshop_dbhelper.dart';

class ConsultaController {
  final _dbHelper = PetShopDBHelper();

  //métodos do Crud

  Future<int> createConsulta(Consulta consulta) async {
    return _dbHelper.insertConsulta(consulta);
  }

  Future<List<Consulta>> readConsultaForPet(int petId) async {
    return _dbHelper.getConsultasForPet(petId);
  }
  //retorna o id da consulta que foi deletada
  Future<int> deleteConsulta(int id) async{
    return _dbHelper.deleteConsulta(id);
  }
}
