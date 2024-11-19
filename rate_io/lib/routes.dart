import 'package:flutter/material.dart';
import 'package:rate_io/perfilOUTROMoradorScreen.dart';
import 'loginScreen.dart'; // Importar suas páginas
import 'registerScreen.dart';
import 'repRegisterScreen.dart';
import 'homeScreen.dart';
import 'avaliaRepScreen.dart'; // Import the AvaliaRepScreen
import 'avaliaMoradorScreen.dart'; // Import the AvaliaMoradorScreen
import 'perfilMoradorScreen.dart'; // Import the PerfilMorador screen
import 'editarPerfilMoradorScreen.dart'; // Import the EditarPerfilMoradorScreen
import 'perfilOUTROMoradorScreen.dart'; // Import the PerfilOUTROMoradorScreen

class Routes {
  static const String login = '/';
  static const String registerScream = '/registerScream';
  static const String homeScream = '/homeScream';
  static const String repRegisterScream = '/repRegisterScream';
  static const String avaliaRepScream = '/avaliaRepScream'; 
  static const String avaliaMoradorScreen = '/avaliaMoradorScreen'; 
  static const String perfilMorador = '/perfilMorador'; 
  static const String editarPerfilMoradorScreen = '/editarPerfilMoradorScreen'; // Add a constant for EditarPerfilMoradorScreen
  static const String perfilOUTROMoradorScreen = '/perfilOUTROmoradorScreen'; // Add a constant for AvaliaMoradorScreen

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
        return MaterialPageRoute(builder: (_) => AvaliaRepScreen()); 
      case avaliaMoradorScreen:
        return MaterialPageRoute(builder: (_) => AvaliaMoradorScreen()); 
      case perfilMorador:
        return MaterialPageRoute(builder: (_) => PerfilMorador()); 
      case editarPerfilMoradorScreen:
        return MaterialPageRoute(builder: (_) => EditarPerfilMoradorScreen()); // Add the route for EditarPerfilMoradorScreen
      case perfilOUTROMoradorScreen:
        return MaterialPageRoute(builder: (_) => Perfiloutromoradorscreen()); // Add the route for 
      default:
        return MaterialPageRoute(builder: (_) => LoginPage()); // Tela padrão
    }
  }
}
