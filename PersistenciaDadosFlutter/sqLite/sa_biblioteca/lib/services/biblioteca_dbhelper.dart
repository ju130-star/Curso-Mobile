import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sa_biblioteca/models/emprestimo_model.dart';
import 'package:sa_biblioteca/models/livros_model.dart';

class BibliotecaDBHelper {
  static Database? _database;

  static final BibliotecaDBHelper _instance = BibliotecaDBHelper._internal();

  BibliotecaDBHelper._internal();
  factory BibliotecaDBHelper() => _instance;

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "biblioteca.db");
    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future<void> _onCreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS livros (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        autor TEXT NOT NULL,
        isbn TEXT NOT NULL,
        ano INT NOT NULL,
        editora TEXT NOT NULL,
        genero TEXT NOT NULL,
        tipo TEXT NOT NULL,
        quantidade_disponivel INT NOT NULL,
        capa TEXT NOT NULL
      );
    ''');
    print("Tabela 'livros' criada.");

    await db.execute('''
      CREATE TABLE IF NOT EXISTS emprestimos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        livro_id INTEGER NOT NULL,
        data_emprestimo DATETIME, 
        previsao_devolucao DATETIME, 
        nome_locatario TEXT NOT NULL,
        data_devolucao TEXT,
        FOREIGN KEY (livro_id) REFERENCES livros(id) ON DELETE CASCADE
      );
    ''');
    print("Tabela 'emprestimos' criada.");
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // CRUD - Livros
  Future<int> insertLivro(Livro livro) async {
    final db = await database;
    return db.insert("livros", livro.toMap());
  }

  Future<List<Livro>> getLivros() async {
    final db = await database;
    final maps = await db.query("livros");
    return maps.map((e) => Livro.fromMap(e)).toList();
  }

  Future<Livro?> getLivroById(int id) async {
    final db = await database;
    final maps = await db.query("livros", where: "id = ?", whereArgs: [id]);
    return maps.isNotEmpty ? Livro.fromMap(maps.first) : null;
  }

  Future<int> deleteLivro(int id) async {
    final db = await database;
    return db.delete("livros", where: "id = ?", whereArgs: [id]);
  }

  // CRUD - Empréstimos
  Future<int> insertEmprestimo(Emprestimo emprestimo) async {
    final db = await database;
    return db.insert("emprestimos", emprestimo.toMap());
  }

  Future<List<Emprestimo>> getEmprestimosForLivro(int livroId) async {
    final db = await database;
    final maps = await db.query(
      "emprestimos",
      where: "livro_id = ?",
      whereArgs: [livroId],
      orderBy: "data_emprestimo ASC",
    );
    return maps.map((e) => Emprestimo.fromMap(e)).toList();
  }

  Future<int> deleteEmprestimo(int id) async {
    final db = await database;
    return db.delete("emprestimos", where: "id = ?", whereArgs: [id]);
  }
}
