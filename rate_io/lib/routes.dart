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
import 'perfilRepScreen.dart'; // Import the PerfilRepScreen
import 'cadastrarContaScreen.dart'; // Import the CadastrarContaScreen
import 'cadastrarPagamentoScreen.dart'; // Import the CadastrarPagamentoScreen
import 'cadastrarEventoScreen.dart';

class Routes {
  static const String login = '/';
  static const String registerScreen = '/registerScreen';
  static const String homeScreen = '/homeScreen';
  static const String repRegisterScreen = '/repRegisterScreen';
  static const String avaliaRepScreen = '/avaliaRepScreen'; 
  static const String avaliaMoradorScreen = '/avaliaMoradorScreen'; 
  static const String perfilMorador = '/perfilMorador'; 
  static const String editarPerfilMoradorScreen = '/editarPerfilMoradorScreen';
  static const String perfilOUTROMoradorScreen = '/perfilOUTROmoradorScreen';
  static const String PerfilrepScreen = '/perfilRepScreen'; 
  static const String CadastroContaScreen = '/cadastrarContaScreen'; 
  static const String cadastrarPagamentoScreen = '/cadastrarPagamentoScreen'; 
  static const String cadastrarEventoScreen = '/cadastrarEventoScreen';

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
        return MaterialPageRoute(builder: (_) => AvaliaRepScreen()); 
      case avaliaMoradorScreen:
        return MaterialPageRoute(builder: (_) => AvaliaMoradorScreen()); 
      case perfilMorador:
        return MaterialPageRoute(builder: (_) => PerfilMorador()); 
      case editarPerfilMoradorScreen:
        return MaterialPageRoute(builder: (_) => EditarPerfilMoradorScreen()); 
      case perfilOUTROMoradorScreen:
        return MaterialPageRoute(builder: (_) => Perfiloutromoradorscreen()); 
      case PerfilrepScreen:
        return MaterialPageRoute(builder: (_) => Perfilrepscreen()); 
      case CadastroContaScreen:
        return MaterialPageRoute(builder: (_) => CadastrarContaScreen()); 
      case cadastrarPagamentoScreen:
        return MaterialPageRoute(builder: (_) => CadastrarPagamentoScreen());
      case cadastrarEventoScreen:
        return MaterialPageRoute(builder: (_) => CadastrarEventoScreen());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage()); // Tela padrão
    }
  }
}
