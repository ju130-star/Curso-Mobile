class Emprestimo {
  // atributos
  final String? id;
  final String? usuario_id;
  final String? livros_id;
  final String data_emprestimo;
  final String? data_devolucao;
  final bool? devolvido;

  // construtor
  Emprestimo({
    this.id,
    this.usuario_id,
    this.livros_id,
    required this.data_emprestimo,
    this.data_devolucao,
    this.devolvido,
  });

  // método toJson
  Map<String, dynamic> toJson() => {
      'id': id,
      'usuario_id': usuario_id,
      'livros_id': livros_id,
      'data_emprestimo': data_emprestimo,
      'data_devolucao': data_devolucao,
      'devolvido': devolvido,
    };
  

  // método fromJson
  factory Emprestimo.fromMap(Map<String, dynamic> map) {
    return Emprestimo(
      id: map["id"]?.toString(),
      usuario_id: map["usuario_id"]?.toString(),
      livros_id: map["livros_id"]?.toString(),
      data_emprestimo: map["data_emprestimo"].toString(),
      data_devolucao: map["data_devolucao"]?.toString(),
      devolvido: map["devolvido"] == 1 ? true : false,
    );
  }
}

