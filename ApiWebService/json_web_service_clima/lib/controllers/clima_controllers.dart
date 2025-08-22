import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_web_service_clima/main.dart';
import 'package:json_web_service_clima/models/clima_model.dart';

class ClimaControllers {
  final String _apiKey = "cdf5441bbc864f0884f4846ea0034383";

  //metodo
  Future<Clima?> getClima(String cidade) async {
    //converte a string em URL
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$_apiKey&units=metric&lang=pt_br",
    );
    //faz requisição
    final res = await http.get(url);
    //faz condicional para verificar
    if (res.statusCode == 200) {
      final dados = json.decode(res.body);
      return Clima.fromJson(dados);
    } else {
      return null;
    }
  }
}
