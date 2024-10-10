import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'routes.dart'; // Importa o arquivo de rotas

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

Future<void> navigateToLoginSream(BuildContext context) async {
  Navigator.of(context).pushReplacementNamed('/');
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Login bem-sucedido, navegue para a próxima tela
      Navigator.of(context).pushReplacementNamed('/homeScream');
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  // Pensar no recuperar senha que a gente é cabaço e não modelamos ela :P)

  void _register(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.registerScream);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectionContainer.disabled(
              child: Transform.translate(
                offset: Offset(0, -150), // Mover 150px para cima (y negativo)
                child: Text(
                  'rate.io',
                  style: TextStyle(
                    fontSize: 128,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontFamily: 'K2D',
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, right: 16, left: 16, bottom: 15),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, right: 16, left: 16, bottom: 15),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, right: 16, left: 16, bottom: 15),
              child: ElevatedButton(
                onPressed: () =>
                    _register(context), // Passa a função corretamente
                child: Text('Criar conta'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, right: 16, left: 16, bottom: 30),
              child: ElevatedButton(
                onPressed: _login,
                child: Text('Recuperar senha'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15), // Aumenta o padding
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  top: 10, right: 16, left: 16, bottom: 30),
              child: ElevatedButton(
                onPressed: _login,
                child: Text('Entrar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15), // Aumenta o padding
                ),
              ),
            ),

            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
