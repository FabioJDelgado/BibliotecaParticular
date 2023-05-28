import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'livro.dart';
import 'livrocontroller.dart';

final ValueNotifier<bool> lido = ValueNotifier<bool>(false);
final listaGeneros = [
      "Ação",
      "Aventura",
      "Comédia",
      "Drama",
      "Ficção Científica",
      "Romance",
      "Suspense",
      "Terror",
    ];
final generoSelecionado = ValueNotifier("");

class Formulario extends StatelessWidget {
  const Formulario({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController titulo = TextEditingController();
    TextEditingController autor = TextEditingController();
    var maskData = MaskTextInputFormatter(mask: '##/##/####');
    TextEditingController lancamento = TextEditingController();

    if(LivroController.acao == "editar"){
      titulo.text = LivroController.livroSelecionado!.titulo.toString();
      autor.text = LivroController.livroSelecionado!.autor.toString();
      lancamento.text = LivroController.livroSelecionado!.lancamento.toString();
      lido.value = LivroController.livroSelecionado!.lido;
      generoSelecionado.value = LivroController.livroSelecionado!.genero;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciar Livro"),
      ),
      body: Container(
        padding: const EdgeInsets.all(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: titulo,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: autor,
              decoration: const InputDecoration(labelText: 'Autor'),
            ),
            TextField(
              inputFormatters: [maskData],
              keyboardType: TextInputType.number,
              controller: lancamento,
              decoration: const InputDecoration(labelText: 'Lançamento'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: lido,
                      builder: (context, value, _) {
                        return Checkbox(
                          value: value,
                          onChanged: (newValue) {
                            lido.value = newValue ?? false;
                          },
                        );
                      },
                    ),
                    const Text("Livro lido"),
                  ],
                ),
                ValueListenableBuilder(
                  valueListenable: generoSelecionado, builder: (BuildContext context, String value, _){
                    return DropdownButton<String>(
                      hint: const Text("Selecione um gênero"),
                      value: (value.isEmpty ? null : value),
                      onChanged: (value) => generoSelecionado.value = value.toString(),
                      items: listaGeneros.map((opcao) => DropdownMenuItem(
                        value: opcao,
                        child: Text(opcao),
                      )).toList(),
                    );
                  }
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if(titulo.text.isEmpty || autor.text.isEmpty || lancamento.text.isEmpty || generoSelecionado.value.isEmpty){
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Atenção',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        content: const Text('É necessário preencher todos os campos!'),
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
                } else{
                  Livro livro = Livro(
                    id: (LivroController.acao == "editar" ? LivroController.livroSelecionado!.id : LivroController.buscaIdLivro()), 
                    titulo: titulo.text,
                    autor: autor.text,
                    genero: generoSelecionado.value,
                    lancamento: lancamento.text,
                    lido: lido.value);
                    if(LivroController.acao == "editar"){
                      LivroController.editarLivro(livro);
                    } else{
                      LivroController.salvarLivro(livro);
                    }
                    Navigator.pop(context);

                    generoSelecionado.value = "";
                    lido.value = false;
                }
              },
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}