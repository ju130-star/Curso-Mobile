class PontoModel {
  final String userId;
  final String data;
  final String hora;
  final double latitude;
  final double longitude;

  PontoModel({
    required this.userId,
    required this.data,
    required this.hora,
    required this.latitude,
    required this.longitude,
  });

  //  Converter objeto para Map (para salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'data': data,
      'hora': hora,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  //  Criar objeto a partir de Map (para ler do Firestore)
  factory PontoModel.fromMap(Map<String, dynamic> map) {
    return PontoModel(
      userId: map['userId'] ?? '',
      data: map['data'] ?? '',
      hora: map['hora'] ?? '',
      latitude: (map['latitude'] ?? 0).toDouble(),
      longitude: (map['longitude'] ?? 0).toDouble(),
    );
  }

  DateTime get dataHora => DateTime.parse('$data $hora');

  //  Representação de texto (debug)
  @override
  String toString() {
    return 'PontoModel(userId: $userId, data: $data, hora: $hora, '
           'latitude: $latitude, longitude: $longitude)';
  }
}
