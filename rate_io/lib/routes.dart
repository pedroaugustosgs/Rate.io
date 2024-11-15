import 'package:flutter/material.dart';
import 'loginScreen.dart'; // Importar suas páginas
import 'registerScreen.dart';
import 'repRegisterScreen.dart';
import 'homeScreen.dart';
import 'avaliaRepScreen.dart'; // Import the AvaliaRepScreen
import 'avaliaMoradorScreen.dart'; // Import the AvaliaMoradorScreen
import 'perfilMoradorScreen.dart'; // Import the PerfilMorador screen

class Routes {
  static const String login = '/';
  static const String registerScream = '/registerScream';
  static const String homeScream = '/homeScream';
  static const String repRegisterScream = '/repRegisterScream';
  static const String avaliaRepScream = '/avaliaRepScream'; // Add a constant for AvaliaRepScreen
  static const String avaliaMoradorScreen = '/avaliaMoradorScreen'; // Add a constant for AvaliaMoradorScreen
  static const String perfilMorador = '/perfilMorador'; // Add a constant for PerfilMorador

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case registerScream:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case homeScream:
        return MaterialPageRoute(builder: (_) => HomePage());
      case repRegisterScream:
        return MaterialPageRoute(builder: (_) => RepRegisterPage());
      case avaliaRepScream:
        return MaterialPageRoute(builder: (_) => AvaliaRepScreen()); // Add the route for AvaliaRepScreen
      case avaliaMoradorScreen:
        return MaterialPageRoute(builder: (_) => AvaliaMoradorScreen()); // Add the route for AvaliaMoradorScreen
      case perfilMorador:
        return MaterialPageRoute(builder: (_) => PerfilMorador()); // Add the route for PerfilMorador
      default:
        return MaterialPageRoute(builder: (_) => LoginPage()); // Tela padrão
    }
  }
}
