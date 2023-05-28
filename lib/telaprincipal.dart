import 'package:biblioteca_particular/livro.dart';
import 'package:flutter/material.dart';
import 'formulario.dart';
import 'livrocontroller.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biblioteca Particular"),
      ),
      body: buscarLivros(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Formulario()))
              .then((_) {
            setState(() {mostrarMensagem("Livro cadastrado com sucesso!");});
          });
        },
        tooltip: "Adicionar Livro",
        child: const Icon(Icons.add),
      ),
    );
  }

  mostrarMensagem(String mensagem ){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Sucesso',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  Widget buscarLivros() {
    
    List<Livro> listaLivro = LivroController.listarLivros();

    if (listaLivro.isNotEmpty) {
      //retornar um table com os livros
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Flexible(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: DataTable(
              /*headingRowHeight: 40,
        dataRowHeight: 56,
        columnSpacing: ,*/
              columns: const [
                DataColumn(
                    label: Expanded(
                  child: Text(
                    'Título',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Autor',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Gênero',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Lançamento',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Lido',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Editar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Excluir',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
              rows: [
                for (var livro in listaLivro)
                  DataRow(cells: [
                    DataCell(Text(livro.titulo)),
                    DataCell(Text(livro.autor)),
                    DataCell(Text(livro.genero)),
                    DataCell(Text(livro.lancamento)),
                    DataCell(livro.lido
                        ? const Icon(Icons.check, color: Colors.green)
                        : const Icon(Icons.close, color: Colors.red)),
                    DataCell(
                      IconButton(
                        onPressed: () {
                          LivroController.acao = "editar";
                          LivroController.livroSelecionado = livro;
                          final resultado = Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Formulario()))
                              .then((_) {
                            setState(() {mostrarMensagem("Livro editado com sucesso!");});
                          });
                        },
                        icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                      ),
                    ),
                    DataCell(
                      IconButton(
                        onPressed: () {
                          LivroController.excluirLivro(livro.id);
                          setState(() {
                            listaLivro = LivroController.listarLivros();
                            mostrarMensagem("Livro excluído com sucesso!");
                          });
                        },
                        icon: const Icon( Icons.delete, color: Colors.red, size: 20),
                      ),
                    )
                  ])
              ],
            ),
          ),
        ),
      ]);
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.book,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              "Nenhum livro cadastrado",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }
  }
}
/*
Widget buscarLivros() {
  LivroController livroController = LivroController();
  List<Livro> listaLivro = livroController.listarLivros();

  if (listaLivro.isNotEmpty) {
    //retornar um table com os livros
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Flexible(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: DataTable(
            /*headingRowHeight: 40,
        dataRowHeight: 56,
        columnSpacing: ,*/
            columns: const [
              DataColumn(
                  label: Expanded(
                child: Text(
                  'Título',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Autor',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Gênero',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Lançamento',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Lido',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Editar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Excluir',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
            rows: [
              for (var livro in listaLivro)
                DataRow(cells: [
                  DataCell(Text(livro.titulo)),
                  DataCell(Text(livro.autor)),
                  DataCell(Text(livro.genero)),
                  DataCell(Text(livro.lancamento)),
                  DataCell(livro.lido
                      ? Icon(Icons.check, color: Colors.green)
                      : Icon(Icons.close, color: Colors.red)),
                  DataCell(IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                    onPressed: () {
                      print("Editar livro ${livro.id}");
                    },
                  )),
                  DataCell(
                    GestureDetector(
                      onTap: () {
                        livroController.excluirLivro(livro.id);
                        setState(() {
                          listaLivro = livroController.listarLivros();
                        });
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  )
                ])
            ],
          ),
        ),
      ),
    ]);
  } else {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.book,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            "Nenhum livro cadastrado",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}*/
