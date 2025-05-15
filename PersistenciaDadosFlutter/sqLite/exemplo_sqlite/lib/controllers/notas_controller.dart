import 'package:exemplo_sqlite/models/notas_model.dart';
import 'package:exemplo_sqlite/services/nota_dbhelper.dart';

class NotasController {
  final NotaDBhelper _dBhelper = NotaDBhelper();

  //4 metodos do crud

  Future<List<Nota>> fetchNota() async {
    return await _dBhelper.getNotas();
  }

  Future<int> addNota(Nota nota) async {
    return await _dBhelper.insertNota(nota);
  }//retorna id da linha inserida

  Future<int> updateNota(Nota nota) async{
    return await _dBhelper.updateNota(nota);
  }

  Future<int> deleteNota(int id) async{
    return await _dBhelper.deleteNota(id);
  }

}

