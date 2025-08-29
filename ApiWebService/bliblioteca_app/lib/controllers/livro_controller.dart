import 'package:bliblioteca_app/models/livros.dart';
import 'package:bliblioteca_app/services/api_service.dart';

class LivroController {
  // GET -> listar todos os livros
  Future<List<Livro>> fetchAll() async {
    final list = await ApiService.getList("livros?_sort=titulo");
    return list.map((item) => Livro.fromMap(item)).toList();
  }

  // GET -> obter um livro pelo id
  Future<Livro> fetchOne(String id) async {
    final livro = await ApiService.getOne("livros", id);
    return Livro.fromMap(livro);
  }

  // POST -> criar novo livro
  Future<Livro> create(Livro book) async {
    final created = await ApiService.post("livros", book.toJson());
    return Livro.fromMap(created);
  }

  // PUT -> atualizar um livro
  Future<Livro> update(Livro book) async {
    final updated = await ApiService.put("livros", book.id!, book.toJson());
    return Livro.fromMap(updated);
  }

  // DELETE ->deletar um livro
  Future<void> delete(String id) async {
     await ApiService.delete("livros", id);
  }
}