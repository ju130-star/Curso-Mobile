class UserModel {
  final String id;
  final String nif;
  final String nome;
  final String email;

  UserModel({
    required this.id,
    required this.nif,
    required this.nome,
    required this.email,
  });

  //  Converter para Map (para salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nif': nif,
      'nome': nome,
      'email': email,
    };
  }

  //  Criar a partir de Map (para ler do Firestore)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      nif: map['nif'] ?? '',
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
    );
  }

  //  Representação de texto (debug)
  @override
  String toString() {
    return 'UserModel(id: $id, nif: $nif, nome: $nome, email: $email)';
  }
}
