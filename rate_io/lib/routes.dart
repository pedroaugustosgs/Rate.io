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
  static const String registerScreen = '/registerScreen';
  static const String homeScreen = '/homeScreen';
  static const String repRegisterScreen = '/repRegisterScreen';
  static const String avaliaRepScreen = '/avaliaRepScreen'; // Add a constant for AvaliaRepScreen
  static const String avaliaMoradorScreen = '/avaliaMoradorScreen'; // Add a constant for AvaliaMoradorScreen
  static const String perfilMorador = '/perfilMorador'; // Add a constant for PerfilMorador

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomePage());
      case repRegisterScreen:
        return MaterialPageRoute(builder: (_) => RepRegisterPage());
      case avaliaRepScreen:
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
