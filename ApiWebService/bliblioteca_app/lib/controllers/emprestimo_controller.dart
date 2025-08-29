import 'package:bliblioteca_app/models/emprestimo.dart';
import 'package:bliblioteca_app/services/api_service.dart';

class EmprestimoController {
  // GET -> listar todos os empréstimos
  Future<List<Emprestimo>> fetchAll() async {
    final list = await ApiService.getList("emprestimos?_sort=data_emprestimo");
    return list.map((item) => Emprestimo.fromMap(item)).toList();
  }

  // GET -> obter um empréstimo pelo id
  Future<Emprestimo> fetchOne(String id) async {
    final emprestimo = await ApiService.getOne("emprestimos", id);
    return Emprestimo.fromMap(emprestimo);
  }

  // POST -> criar novo empréstimo
  Future<Emprestimo> create(Emprestimo emp) async {
    final created = await ApiService.post("emprestimos", emp.toJson());
    return Emprestimo.fromMap(created);
  }

  // PUT -> atualizar um empréstimo
  Future<Emprestimo> update(Emprestimo emp) async {
    final updated = await ApiService.put("emprestimos", emp.id!, emp.toJson());
    return Emprestimo.fromMap(updated);
  }

  // DELETE -> deletar um empréstimo
  Future<void> delete(String id) async {
     await ApiService.delete("emprestimos", id);
  }
}