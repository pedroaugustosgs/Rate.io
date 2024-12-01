import 'package:flutter/material.dart';
import 'package:rate_io/buscaScreen.dart';
import 'package:rate_io/perfilUsuarioScreen.dart';
import 'loginScreen.dart'; // Importar suas páginas
import 'registerScreen.dart';
import 'repRegisterScreen.dart';
import 'homeScreen.dart';
import 'avaliaRepScreen.dart'; // Import the AvaliaRepScreen
import 'avaliaMoradorScreen.dart'; // Import the AvaliaMoradorScreen
import 'meuPerfilScreen.dart'; // Import the PerfilMorador screen
import 'editarMeuPerfilScreen.dart'; // Import the EditarPerfilMoradorScreen
import 'perfilRepScreen.dart'; // Import the PerfilRepScreen
import 'cadastrarContaScreen.dart'; // Import the CadastrarContaScreen
import 'cadastrarPagamentoScreen.dart'; // Import the CadastrarPagamentoScreen
import 'cadastrarEventoScreen.dart';
import 'mostraMoradoresScreen.dart';

class Routes {
  static const String login = '/';
  static const String registerScreen = '/registerScreen';
  static const String homeScreen = '/homeScreen';
  static const String repRegisterScreen = '/repRegisterScreen';
  static const String avaliaRepScreen = '/avaliaRepScreen'; 
  static const String avaliaMoradorScreen = '/avaliaMoradorScreen'; 
  static const String perfilMorador = '/perfilMorador'; 
  static const String editarPerfilMoradorScreen = '/editarPerfilMoradorScreen';
  static const String perfilUsuarioScreen = '/perfilUsuarioScreen';
  static const String PerfilrepScreen = '/perfilRepScreen'; 
  static const String CadastroContaScreen = '/cadastrarContaScreen'; 
  static const String cadastrarPagamentoScreen = '/cadastrarPagamentoScreen'; 
  static const String cadastrarEventoScreen = '/cadastrarEventoScreen';
  static const String buscaScreen = '/buscaScreen';
  static const String mostraMoradoresScreen = '/mostraMoradoresScreen';

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
      case perfilMorador:
        return MaterialPageRoute(builder: (_) => PerfilMorador()); 
      case editarPerfilMoradorScreen:
        return MaterialPageRoute(builder: (_) => EditarPerfilMoradorScreen());  
      case PerfilrepScreen:
        return MaterialPageRoute(builder: (_) => Perfilrepscreen()); 
      case CadastroContaScreen:
        return MaterialPageRoute(builder: (_) => CadastrarContaScreen()); 
      case cadastrarPagamentoScreen:
        return MaterialPageRoute(builder: (_) => CadastrarPagamentoScreen());
      case cadastrarEventoScreen:
        return MaterialPageRoute(builder: (_) => CadastrarEventoScreen());
      case buscaScreen:
        return MaterialPageRoute(builder: (_) => BuscaScreen());
      case mostraMoradoresScreen:
        return MaterialPageRoute(
          builder: (_) => MostraMoradoresScreen(),
          settings: RouteSettings(
            arguments:
                settings.arguments, // Passa o argumento para a tela de destino
          ),
        );
      case perfilUsuarioScreen:
        return MaterialPageRoute(
          builder: (_) => PerfilUsuarioScreen(morador: {},),
          settings: RouteSettings(
            arguments:
                settings.arguments,
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => LoginPage()); // Tela padrão
    }
  }
}
