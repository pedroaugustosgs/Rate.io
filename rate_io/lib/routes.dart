import 'package:flutter/material.dart';
import 'package:rate_io/convidarUsuarioScreen.dart';
import 'package:rate_io/verAvaliacoesScreen.dart';
import 'package:rate_io/buscaScreen.dart';
import 'package:rate_io/perfilUsuarioScreen.dart';
import 'loginScreen.dart';
import 'registerScreen.dart';
import 'repRegisterScreen.dart';
import 'homeScreen.dart';
import 'avaliaRepScreen.dart';
import 'avaliaMoradorScreen.dart'; 
import 'editarMeuPerfilScreen.dart'; 
import 'perfilRepScreen.dart';
import 'cadastrarContaScreen.dart'; 
import 'cadastrarPagamentoScreen.dart'; 
import 'cadastrarEventoScreen.dart';
import 'mostraMoradoresScreen.dart';
import 'fluxoDeCaixaScreen.dart';

class Routes {
  static const String login = '/';
  static const String registerScreen = '/registerScreen';
  static const String homeScreen = '/homeScreen';
  static const String repRegisterScreen = '/repRegisterScreen';
  static const String avaliaRepScreen = '/avaliaRepScreen';
  static const String avaliaMoradorScreen = '/avaliaMoradorScreen';
  static const String editarPerfilMoradorScreen = '/editarPerfilMoradorScreen';

  static const String perfilUsuarioScreen = '/perfilUsuarioScreen';
  static const String perfilRepScreen = '/perfilRepScreen'; 
  static const String CadastroContaScreen = '/cadastrarContaScreen'; 
  static const String cadastrarPagamentoScreen = '/cadastrarPagamentoScreen'; 

  static const String cadastrarEventoScreen = '/cadastrarEventoScreen';
  static const String buscaScreen = '/buscaScreen';
  static const String mostraMoradoresScreen = '/mostraMoradoresScreen';
  static const String fluxoDeCaixaScreen = '/fluxoDeCaixaScreen';
  static const String verAvaliacoesScreen = '/verAvaliacoesScreen';
  static const String convidarUsuarioScreen = '/convidarUsuarioScreen';

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
      case editarPerfilMoradorScreen:
        return MaterialPageRoute(builder: (_) => EditarPerfilMoradorScreen());  
      case perfilRepScreen:
        return MaterialPageRoute(builder: (_) => PerfilRepScreen(rep: {},));
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
                settings.arguments,
          ),
        );
      case fluxoDeCaixaScreen:
        return MaterialPageRoute(builder: (_) => FluxoDeCaixaScreen());
      case perfilUsuarioScreen:
        return MaterialPageRoute(builder: (_) => PerfilUsuarioScreen(morador: {},));
      case verAvaliacoesScreen:
        return MaterialPageRoute(builder: (_) => VerAvaliacoesScreen(usuario: {},));
      case avaliaMoradorScreen:
        return MaterialPageRoute(builder: (_) => AvaliaMoradorScreen(morador: {}));
      case convidarUsuarioScreen:
        return MaterialPageRoute(builder: (_) => ConvidarUsuarioScreen(usuario: {}));
      default:
        return MaterialPageRoute(builder: (_) => LoginPage()); // Tela padrão
    }
  }
}
