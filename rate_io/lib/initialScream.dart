import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loginScream.dart'; // Importa a tela de login

class InitialScream extends StatefulWidget {
  @override
  _InitialScreamState createState() => _InitialScreamState(); // Cria um estado inicial do texto 
}

class _InitialScreamState extends State<InitialScream> // fazendo a classe herdar os estados ( tendi merda nenhuma)
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    // Essa parte é a configuração da animação 
    _controller = AnimationController( // Inicializa o AnimationController
      duration: Duration(seconds: 1), // Duração do efeito de fade
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);     // Define a animação do fade

    _controller.forward();   // Inicia a animação

    // Redireciona para a tela de login após 5 segundos
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera o controlador ao descartar o widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Text(
            'rate.io',
            style: GoogleFonts.k2d(
              fontSize: 128,
              color: Color(0xFF1F9BF2), // Cor do texto
            ),
          ),
        ),
      ),
    );
  }
}
