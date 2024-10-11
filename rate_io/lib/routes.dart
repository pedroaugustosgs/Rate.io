import 'package:flutter/material.dart';
import 'loginScream.dart'; // Importar suas páginas
import 'registerScream.dart';
import 'homeScream.dart';

class Routes {
  static const String login = '/';
  static const String registerScream = '/registerScream';
  static const String homeScream = '/homeScream';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case registerScream:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case homeScream:
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage()); // Tela padrão
    }
  }
}
