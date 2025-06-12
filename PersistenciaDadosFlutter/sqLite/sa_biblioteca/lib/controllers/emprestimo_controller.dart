import 'package:sa_biblioteca/models/emprestimo_model.dart';
import 'package:sa_biblioteca/services/biblioteca_dbhelper.dart';

class EmprestimoController {
  final _dbHelper = BibliotecaDBHelper();

  // Métodos do CRUD

  /// Cria um novo empréstimo
  Future<int> createEmprestimo(Emprestimo emprestimo) async {
    return _dbHelper.insertEmprestimo(emprestimo);
  }

  /// Lista todos os empréstimos de um livro específico
  Future<List<Emprestimo>> readEmprestimosForLivro(int livroId) async {
    return _dbHelper.getEmprestimosForLivro(livroId);
  }

  /// Deleta um empréstimo e retorna seu ID
  Future<int> deleteEmprestimo(int id) async {
    return _dbHelper.deleteEmprestimo(id);
  }
}
