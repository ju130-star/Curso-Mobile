import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sa_geolocator/models/location_points.dart';

class MapController {
  final DateFormat _formatar = DateFormat("dd/MM/yyyy - HH:mm:ss");

  //método para pegar a geolocalização do ponto
  Future<LocationPoints> getcurrentLocation() async {
    //solictar a klocalização atual do dispositivo
    //liberar permissões
    //verificar se o aplicativo possui o serviço de geolocalização habilitado
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      throw Exception("Sem Acesso ao GPS");
    }
    LocationPermission permission;
    //verificar a permissão de uso do gps
    permission = await Geolocator.checkPermission();
    //por padrão todo nnovo aplicativo instalado não possui permissão de acesso aos hardwares
    if (permission == LocationPermission.denied) {
      // solicitar o acesso a geolocalização
      permission == await Geolocator.requestPermission();
      if (permission == LocationPermission.denied){
        throw Exception("Permissão Negada de Acesso ao GPS");
      }
    }
    // o acesso foi liberado
    Position position = await Geolocator.getCurrentPosition();
    //pegar a data e a hora ( e formata no padrão BR)
    String dataHora = _formatar.format(DateTime.now());
    //criar um OBJ do Model
    LocationPoints posicaoAtual = LocationPoints(
      latitude: position.latitude, 
      longitude: position.longitude, 
      timeStamp: dataHora);
    
    //devolve o Obj
    return posicaoAtual;
  }
}
