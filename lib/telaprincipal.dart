import 'package:biblioteca_particular/livro.dart';
import 'package:flutter/material.dart';
import 'formulario.dart';
import 'livrocontroller.dart';
import 'util.dart';

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
            setState(() {
              if(LivroController.alerta == "cadastrado"){
                Utils.mostrarAlert(context, "Sucesso", "Livro cadastrado com sucesso!", Colors.green);
                LivroController.alerta = "";
              }
            });
          });
        },
        tooltip: "Adicionar Livro",
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buscarLivros() {
    
    List<Livro> listaLivro = LivroController.listarLivros();
    listaLivro.sort((a, b) => a.titulo.compareTo(b.titulo));

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
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Formulario()))
                              .then((_) {
                            setState(() {
                              if(LivroController.alerta == "editado"){
                                Utils.mostrarAlert(context, "Sucesso", "Livro editado com sucesso!", Colors.green);
                                LivroController.alerta = "";
                              }
                              LivroController.acao = "";
                              
                            });
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
                            Utils.mostrarAlert(context, "Sucesso", "Livro excluído com sucesso!", Colors.green);
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
