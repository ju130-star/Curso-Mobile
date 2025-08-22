class Usuario {
  // atributos
  final String? id; // pode ser nulo inicialmente
  final String nome;
  final String email;

  // construtor
  Usuario({
    this.id,
    required this.nome,
    required this.email,
  });

  // método toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
    };
  }

  // método fromJson
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json["id"]?.toString(),
      nome: json["nome"].toString(),
      email: json["email"].toString(),
    );
  }
}