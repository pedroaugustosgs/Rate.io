import 'package:flutter/material.dart';
// Importa o arquivo de rotas
// Certifique-se de importar esta biblioteca

Future<void> navigateToHomeScream(BuildContext context) async {
  Navigator.of(context).pushReplacementNamed('/homeScream');
}

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
 @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
