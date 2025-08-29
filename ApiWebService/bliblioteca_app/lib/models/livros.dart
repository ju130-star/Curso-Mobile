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
  Map<String, dynamic> toJson() => {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'disponivel': disponivel,
    };
  

  // método fromJson
  factory Livro.fromMap(Map<String, dynamic> map) => Livro(
      id: map["id"]?.toString(),
      titulo: map["titulo"].toString(),
      autor: map["autor"].toString(),
      disponivel: map["disponivel"] == 1 ? true : false,
    );
  }

