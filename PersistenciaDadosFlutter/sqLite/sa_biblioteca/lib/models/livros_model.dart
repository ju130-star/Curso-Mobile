class Livro {
  final int? id;
  final String titulo;
  final String autor;
  final String isbn;
  final int ano;
  final String editora;
  final String genero;
  final String tipo; // físico ou e-book
  final int quantidadeDisponivel;
  final String capa; // Dura ou fle

  Livro({
    this.id,
    required this.titulo,
    required this.autor,
    required this.isbn,
    required this.ano,
    required this.editora,
    required this.genero,
    required this.tipo,
    required this.quantidadeDisponivel,
    required this.capa,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'isbn': isbn,
      'ano': ano,
      'editora': editora,
      'genero': genero,
      'tipo': tipo,
      'quantidade_disponivel': quantidadeDisponivel,
      'capa': capa,
    };
  }

  factory Livro.fromMap(Map<String, dynamic> map) {
    return Livro(
      id: map['id'] as int?,
      titulo: map['titulo'] as String,
      autor: map['autor'] as String,
      isbn: map['isbn'] as String,
      ano: map['ano'] as int,
      editora: map['editora'] as String,
      genero: map['genero'] as String,
      tipo: map['tipo'] as String,
      quantidadeDisponivel: map['quantidade_disponivel'] as int,
      capa: map['capa'] as String,
    );
  }
}
