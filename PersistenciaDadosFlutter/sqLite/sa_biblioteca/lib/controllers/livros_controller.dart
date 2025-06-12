import 'package:sa_biblioteca/services/biblioteca_dbhelper.dart';
import '../models/livros_model.dart';

class LivroController {
  final BibliotecaDBHelper _dbHelper = BibliotecaDBHelper();

  /// Cria um novo livro no banco de dados
  Future<int> createLivro(Livro livro) async {
    return await _dbHelper.insertLivro(livro);
  }

  /// Retorna a lista de todos os livros
  Future<List<Livro>> readLivros() async {
    return await _dbHelper.getLivros();
  }

  /// Retorna um livro pelo ID
  Future<Livro?> readLivroById(int id) async {
    return await _dbHelper.getLivroById(id);
  }

  /// Deleta um livro pelo ID
  Future<int> deleteLivro(int id) async {
    return await _dbHelper.deleteLivro(id);
  }
}
