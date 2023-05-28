class Livro {
  int id;
  String titulo;
  String autor;
  String genero;
  String lancamento;
  bool lido;

  Livro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.genero,
    required this.lancamento,
    required this.lido,
  });

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      id: json['id'],
      titulo: json['titulo'],
      autor: json['autor'],
      genero: json['genero'],
      lancamento: json['lancamento'],
      lido: json['lido']
    );
  } 

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'genero': genero,
      'lancamento': lancamento,
      'lido': lido
    };
  }
}