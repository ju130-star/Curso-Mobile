class Livro {
  // atributos
  final String? id;
  final String titulo;
  final String autor;
  final bool disponivel;

  // construtor
  Livro({
    this.id,
    required this.titulo,
    required this.autor,
    required this.disponivel,
  });

  // método toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'disponivel': disponivel,
    };
  }

  // método fromJson
  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      id: json["id"]?.toString(),
      titulo: json["titulo"].toString(),
      autor: json["autor"].toString(),
      disponivel: json["disponivel"] is bool
          ? json["disponivel"]
          : json["disponivel"]?.toString().toLowerCase() == 'true',
    );
  }
}
