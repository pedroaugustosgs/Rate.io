import 'package:flutter/material.dart';
import 'loginScream.dart'; // Importar suas páginas
import 'registerScream.dart';

class Routes {
  static const String login = '/';
  static const String registerScream = '/registerScream';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case registerScream:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage()); // Tela padrão
    }
  }
}
