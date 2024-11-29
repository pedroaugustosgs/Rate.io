import 'package:flutter/material.dart';
import 'package:rate_io/mostraMoradoresScreen.dart';
import 'package:rate_io/perfilOUTROMoradorScreen.dart';
import 'loginScreen.dart'; // Importar suas páginas
import 'registerScreen.dart';
import 'repRegisterScreen.dart';
import 'homeScreen.dart';
import 'avaliaRepScreen.dart'; // Import the AvaliaRepScreen
import 'avaliaMoradorScreen.dart'; // Import the AvaliaMoradorScreen
import 'perfilMoradorScreen.dart'; // Import the PerfilMorador screen
import 'editarPerfilMoradorScreen.dart'; // Import the EditarPerfilMoradorScreen
// Import the PerfilOUTROMoradorScreen
import 'perfilRepScreen.dart'; // Import the PerfilRepScreen
import 'cadastrarContaScreen.dart'; // Import the CadastrarContaScreen
import 'cadastrarPagamentoScreen.dart'; // Import the CadastrarPagamentoScreen

class Routes {
  static const String login = '/';
  static const String registerScreen = '/registerScreen';
  static const String homeScreen = '/homeScreen';
  static const String repRegisterScreen = '/repRegisterScreen';
  static const String avaliaRepScreen = '/avaliaRepScreen';
  static const String avaliaMoradorScreen = '/avaliaMoradorScreen';
  static const String perfilMorador = '/perfilMorador';
  static const String editarPerfilMoradorScreen =
      '/editarPerfilMoradorScreen'; // Add a constant for EditarPerfilMoradorScreen
  static const String perfilOUTROMoradorScreen =
      '/perfilOUTROmoradorScreen'; // Add a constant for AvaliaMoradorScreen
  static const String PerfilrepScreen =
      '/perfilRepScreen'; // Add a constant for Perfilrepscreen
  static const String CadastroContaScreen =
      '/cadastrarContaScreen'; // Add a constant for CadastrarContaScreen
  static const String cadastrarPagamentoScreen =
      '/cadastrarPagamentoScreen'; // Add a constant for CadastrarPagamentoScreen
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
      case avaliaMoradorScreen:
        return MaterialPageRoute(
          builder: (_) => AvaliaMoradorScreen(
            morador: settings.arguments
                as Map<String, dynamic>, // Aqui passamos o argumento morador
          ),
          settings: RouteSettings(
            arguments:
                settings.arguments, // Passa o argumento para a tela de destino
          ),
        );
      case perfilMorador:
        return MaterialPageRoute(builder: (_) => PerfilMorador());
      case editarPerfilMoradorScreen:
        return MaterialPageRoute(
            builder: (_) =>
                EditarPerfilMoradorScreen()); // Add the route for EditarPerfilMoradorScreen
      case perfilOUTROMoradorScreen:
        return MaterialPageRoute(
            builder: (_) => Perfiloutromoradorscreen()); // Add the route for
      case PerfilrepScreen:
        return MaterialPageRoute(
            builder: (_) =>
                Perfilrepscreen()); // Add the route for Perfilrepscreen
      case CadastroContaScreen:
        return MaterialPageRoute(
            builder: (_) =>
                CadastrarContaScreen()); // Add the route for CadastrarContaScreen
      case cadastrarPagamentoScreen:
        return MaterialPageRoute(
            builder: (_) =>
                CadastrarPagamentoScreen()); // Add the route for CadastrarPagamentoScreen
      case mostraMoradoresScreen:
        return MaterialPageRoute(
          builder: (_) => MostraMoradoresScreen(),
          settings: RouteSettings(
            arguments:
                settings.arguments, // Passa o argumento para a tela de destino
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => LoginPage()); // Tela padrão
    }
  }
}
