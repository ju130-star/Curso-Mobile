//classe de ajuda para conexão com db

import 'package:sa_petshop/models/cansulta_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/pet_model.dart';

class PetShopDBHelper {
  //fazer conexão singleton
  static Database? _database; //obj da SQLite conexão com BD
  // static refere ao metodo e não pelo obj
  static final PetShopDBHelper _instance = PetShopDBHelper._internal();

  PetShopDBHelper._internal(); // named constructor for singleton
  factory PetShopDBHelper() {
    return _instance;
  }

  //verificação do banco de dados -> verifica se ja foi criado e se já foi aberto
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "petshop.db");

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  // método para criação de tabelas
  _onCreateDB(Database db, int version) async {
    //criar a Tabela do Pet
    await db.execute("""""CREATE TABLE IF NOT EXISTS pets(
          ID INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          raca TEXT NOT NULL,
          nome_dono TEXT NOT NULL,
          telefone_dono TEXT NOT NULL,
          )""");
    print("Tabelas pets criada");
    await db.execute("""CREATE TABLE IF NOT EXISTS consultas(
      id INTEGERPRIMARY KEY AUTOINCREMENT,
      pet_id INTEGER NOT NULL,
      data_hora TEXT NOT NULL,
      tipo_servico TEXT NOT NULL,
      observacao TEXT NOT NULL,
      FOREING KEY(pet_id) REFERENCES pets(id) ON DELETE CASCADE)""");

    print("tabela consulta criada");
  }

  //verifica se o banco já foi iniciado, caso contrario inicia a conexão
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  //metodo crud pets
  Future<int> insertPet(Pet pet) async {
    final db = await database; //verifica a conexão
    return db.insert("pets", pet.toMap()); //inserir o dado no banco
  }

  Future<List<Pet>> getPets() async {
    final db = await database; //verifica a conexão
    final List<Map<String, dynamic>> maps = await db.query(
      "pets",
    ); //pegar os dados do banco
    return maps.map((e) => Pet.fromMap(e)).toList(); //factory do BD -> obj
  }

  Future<Pet?> getPetById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "pets",
      where: "id=?",
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      return null;
    } else {
      Pet.fromMap(maps.first);
    }
    return null;
  }

  Future<int> deletePet(int id) async {
    final db = await database;
    return await db.delete("pets", where: "id=?", whereArgs: [id]);
  } //DELETE  ON CASCADE  na tabela Consulta

  //CRUD e CRIAR o Banco de Dados das Consultas
  Future<int> insertConsulta(Consulta consulta) async {
    final db = await database;
    return await db.insert(
      "consultas",
      consulta.toMap(),
    ); //insere no banco de dados
  }

  Future<List<Consulta>> getConsultasForPet(int petID) async {
    final db = await database;
    // consulta por pet expecífico
    List<Map<String, dynamic>> maps = await db.query(
      "consultas",
      where: "pet_id =?",
      whereArgs: [petId],
    );
    // converter a map para obj
    return maps.map((e) => Consulta.fromMap(e)).toList();
    //toList() -> forma abreviada de escrever um laço de repetição do tipo (forEach)
  }

  Future<int> deleteConsulta(int id) async {
    final db = await database;
    return db.delete("consultas", where: "id=?", whereArgs: [id]);
    //delete from table consultas where id =?,
  }
}
