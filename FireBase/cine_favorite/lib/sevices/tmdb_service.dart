// maeu serviço de conexão api

import 'dart:convert';

import 'package:http/http.dart' as http;

class TmdbService{
  //colocar os dados da api
  static const String _apikey = "1fa5c2d59029fd1c438cc35713720604";
  static const String _baseUrl = "https://api.themoviedb.org/3";
  static const String _idioma = "pt-BR";

  //método para buscar filme com base no texto
  static Future<List<Map<String, dynamic>>> schearchMovies(String query) async {
    //convertre a string em url
    final apiUrl = Uri.parse("$_baseUrl/search/movie?api_key=$_apikey&query=$query&language=$_idioma");
    //http get
    final response = await http.get(apiUrl);
    //verifica se a resposta foi ok
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
     //caso der erro cria um exception
      throw Exception('Falha ao carregar filmes de API');
    }
  }
}