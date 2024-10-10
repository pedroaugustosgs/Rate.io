import 'package:flutter/material.dart';
import 'routes.dart'; // Importa o arquivo de rotas
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'classes/user.dart';
import 'package:intl/intl.dart'; // Certifique-se de importar esta biblioteca
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
