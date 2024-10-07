import 'package:flutter/material.dart';
import 'routes.dart'; // Importa o arquivo de rotas

Future<void> navigateToRegisterScreen(BuildContext context) async {
  Navigator.of(context).pushReplacementNamed('/registerScream');
}

  void _login(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.login);
  }


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> _register() async {
      Navigator.of(context).pushReplacementNamed('/registerScream');
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
                offset: Offset(0, -150), // Mover 400px para cima (y negativo)
                child: Text(
                  'rate.io',
                  style: TextStyle(
                    fontSize: 98,
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
               onPressed: () => _login(context), // Passa a função corretamente
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
