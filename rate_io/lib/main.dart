import 'package:flutter/material.dart'; // Para widgets do Flutter
import 'package:firebase_core/firebase_core.dart'; // Para inicializar o Firebase
import 'firebase_options.dart'; // Para as opções de configuração do Firebase
import 'initialScream.dart'; // Importa sua tela inicial
import 'routes.dart';

void main() async {
  // Assegura que os widgets do Flutter estão inicializados antes de usar
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    print("Firebase inicializado com sucesso!"); // Mensagem de sucesso
  } catch (e) {
    print("Erro ao inicializar o Firebase: $e"); // Mensagem de erro
  }

  // Executa o aplicativo
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rate.io',
      initialRoute: Routes.login,
      onGenerateRoute: Routes.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'K2D',
        scaffoldBackgroundColor: const Color(0xffefefef),
        appBarTheme: const AppBarTheme(
          color: Color(0x00B1B0B0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
                foregroundColor: Color(0xFF497A9D))),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(
            color: Color(0xFF497A9D), // Cor do texto da label
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
                color: Color(0xFF497A9D)), // Cor da linha quando em foco
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(
                fontSize: 138), // Tamanho da fonte padrão para TextButton
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            textStyle: TextStyle(
                fontSize: 138), // Tamanho da fonte padrão para OutlinedButton
          ),
        ),
        sliderTheme: SliderThemeData(
          activeTickMarkColor: Color(0xFF74c3fc),
          activeTrackColor:Color(0xFF497A9D),
          thumbColor: Color(0xFF497A9D),
          valueIndicatorColor: Color(0xFF497A9D),
          inactiveTrackColor: Color(0xFF74c3fc),
          inactiveTickMarkColor: Color(0xffefefef),
        )
      ),
      home:
          const InitialScream(), // Tela inicial após o Firebase ser inicializado
    );
  }
}
