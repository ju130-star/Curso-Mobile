class Nota {
  //atributos
  int?
  id; //permite nula em um primeiro momento(banco de dados vai forvecer  o id )
  String titulo;
  String conteudo;

  //constructor
  Nota({this.id, required this.titulo, required this.conteudo}); //

  //metodos
  //converter objetos <=> Banco de dados

  //toMap : Objetos -> BD

  Map<String, dynamic> toMap() => {
    "id": id,
    "titulo": titulo,
    "conteudo": conteudo,
  };
  //converter um objeto da classe nota para um map(referenciado no banco de dados)

  //fromMap : BD -> Objeto
  factory Nota.fromMap(Map<String, dynamic> map) => Nota(
    id: map['id'] as int,
    titulo: map['titulo'] as String,
    conteudo: map['conteudo'] as String
  );

 @override
  String toString(){
    return "Nota{id: $id, titulo: $titulo, conteudo: $conteudo}";
  }
  }

