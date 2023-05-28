import 'package:flutter/material.dart';
import 'telaprincipal.dart';

void main() {
  runApp(const BibliotecaParticular());
}

class BibliotecaParticular extends StatelessWidget {
  const BibliotecaParticular({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Biblioteca Particular",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaPrincipal(),
    );
  }
}