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
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

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
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () => _register(context), // Passa a função corretamente
              child: Text('Registrar-se'),
            ),
            SizedBox(height: 20),
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
