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
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usuario_id': usuario_id,
      'livros_id': livros_id,
      'data_emprestimo': data_emprestimo,
      'data_devolucao': data_devolucao,
      'devolvido': devolvido,
    };
  }

  // método fromJson
  factory Emprestimo.fromJson(Map<String, dynamic> json) {
    return Emprestimo(
      id: json["id"]?.toString(),
      usuario_id: json["usuario_id"]?.toString(),
      livros_id: json["livros_id"]?.toString(),
      data_emprestimo: json["data_emprestimo"].toString(),
      data_devolucao: json["data_devolucao"]?.toString(),
      devolvido: json["devolvido"] is bool
          ? json["devolvido"]
          : json["devolvido"]?.toString().toLowerCase() == 'true',
    );
  }
}

