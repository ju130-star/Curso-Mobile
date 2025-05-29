//classe modelos -> conectar com as entidades do BD

class Pet {
  //atributos
  final int? id; //permite ser nulo
  final String nome;
  //final = uma variavel que começa com um valor e pode trocar apenas uma vez
  final String raca;
  final String nomeDono;
  final String telefoneDono;

  Pet({
    this.id,
    required this.nome,
    required this.raca,
    required this.nomeDono,
    required this.telefoneDono,
  });

  //métodos de conversão -> obj-> BG : BG ->obj

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "raca": raca,
      "nome_dono": nomeDono,
      "telefone_dono": telefoneDono,
    };
  }

  factory Pet.frommap(Map<String, dynamic> map) {
    return Pet(
      id: map["id"] as int,
      nome: map["nome"] as String,
      raca: map["raca"] as String,
      nomeDono: map["nome_dono"] as String,
      telefoneDono: map["telefone_dono"] as String,
    );
  }

  static fromMap(Map<String, dynamic> e) {}
}
