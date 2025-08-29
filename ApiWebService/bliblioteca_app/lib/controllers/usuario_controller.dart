//classe para controller dos usuarios

import 'package:bliblioteca_app/models/usuario.dart';
import 'package:bliblioteca_app/services/api_service.dart';

class UsuarioController {
  // métodos
  //GET do usuario
  Future<List<Usuario>> fetchAll() async {
    //pega a lista de usuario no formato list<dynamic>
    final list = await ApiService.getList("usuarios?_sort=nome");
    //retornar a lista de usuarios convertidos 
    return list.map((item)=> Usuario.fromJson(item)).toList();
  }
  //GET de um usuario
  Future<Usuario> fetchOne(String id)async{
    final usuario = await ApiService.getOne("usuarios", id);
    return Usuario.fromJson(usuario);
  }
  //post -> criar novo usuario
  Future<Usuario> create(Usuario user) async {
  final created = await ApiService.post("usuarios", user.toJson());
  return Usuario.fromJson(created);
}
  //put -> alterar um usuario
Future<Usuario> update(Usuario user) async {
  final updated = await ApiService.put("usuarios", user.id!, user.toJson());
  return Usuario.fromJson(updated);
}
  //delete -> deletar um usuario
  Future<void> delete(String id) async {
    await ApiService.delete("usuarios", id);
  }
}