import 'dart:convert';
import 'livro.dart';
import 'localstorage.dart';

class LivroController{

  static List<Livro> listaLivro = [];
  static Livro? livroSelecionado;
  static String acao = "";
  static String alerta = "";

  static List<Livro> listarLivros() {
    String livrosLS = loadData("livros");
    if(livrosLS.isNotEmpty){
      List<dynamic> listaMapLivro = jsonDecode(livrosLS);
      listaLivro = listaMapLivro.map((livro) => Livro.fromJson(livro)).toList();
    }
    return listaLivro;
  }

  static int buscaIdLivro(){
    int id = 1;
    String idLS = loadData("idContLivro");
    if(idLS.isNotEmpty){
      id = int.parse(idLS) + 1;
    }
    saveData("idContLivro", id.toString());
    return id;
  }

  static void salvarLivro(Livro livro) {
    listaLivro = listarLivros();
    listaLivro.add(livro);
    List<Map<String, dynamic>> listaMapLivro = listaLivro.map((livro) => livro.toJson()).toList();
    saveData("livros", jsonEncode(listaMapLivro));
    alerta = "cadastrado";
  }

  static void editarLivro(Livro livro) {
    listaLivro = listarLivros();
    listaLivro.removeWhere((element) => element.id == livro.id);
    listaLivro.add(livro);
    List<Map<String, dynamic>> listaMapLivro = listaLivro.map((livro) => livro.toJson()).toList();
    saveData("livros", jsonEncode(listaMapLivro));
    acao = "";
    alerta = "editado";
  }

  static void excluirLivro(int id) {
    listaLivro = listarLivros();
    listaLivro.removeWhere((element) => element.id == id);
    List<Map<String, dynamic>> listaMapLivro = listaLivro.map((livro) => livro.toJson()).toList();
    saveData("livros", jsonEncode(listaMapLivro));
  }
}

