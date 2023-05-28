import 'package:flutter/material.dart';

class Utils{

  static Future<void> mostrarAlert(BuildContext context, String titulo, String mensagem, Color cor){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            titulo,
            style: TextStyle(
              color: cor,
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

}