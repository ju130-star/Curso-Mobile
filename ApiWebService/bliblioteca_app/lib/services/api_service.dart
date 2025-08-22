//classe de ajuda para conexão com Api

import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  //base url para conexão
  static const _baseUrl = "http://10.109.197.25:3013";

  //métodos statics( método de classe e não de objeto)

  //GET -> listar todos os recusrsos
  static Future<List<dynamic>> getList(String path) async {
    final res = await http.get(Uri.parse("$_baseUrl/$path"));
    if (res.statusCode == 200)
      return json.decode(res.body); // se der certo interrompe o metodo
    //se não deu certo a conexão -> gera um erro
    throw Exception("Falha ao carregar Lista de $path"); //deve ser tratado
  }

  //GET -> listar apenas um recurso
  static Future<Map<String, dynamic>> getOne(String path, String id) async {
    final res = await http.get(Uri.parse("$_baseUrl/$path/$id"));
    if (res.statusCode == 200) return json.decode(res.body);
    //se der erro
    throw Exception("Erro ao carregar recurso de$path/$id");
  }

  //POST -> adicionar recurso
  static Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    final res = await http.post(
      //URL/Header/Body
      Uri.parse("$_baseUrl/$path"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    if (res.statusCode == 201) return json.decode(res.body);
    throw Exception("Erro ao criar recurso em $path");
  }

  //PUT -> atualizar um recurso
  static Future<Map<String, dynamic>> put(
    String path,
    Map<String, dynamic> body,
  ) async {
    final res = await http.put(
      //URL/Header/Body
      Uri.parse("$_baseUrl/$path/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    if (res.statusCode == 200) return json.decode(res.body);
    throw Exception("Erro ao atualizar recurso em $path");
  }
  //DELETE -> deletar um recurso
  static delete (String path, String id) async {
    final res = await http.delete(
      Uri.parse("$_baseUrl/$path/$id"));
    if (res.statusCode == 200) throw Exception("Erro ao deletar recurso em $path/$id");
  }
}
