import 'package:flutter/material.dart'; // Para widgets do Flutter
import 'package:firebase_core/firebase_core.dart'; // Para inicializar o Firebase
import 'package:provider/provider.dart';
import 'package:rate_io/classes/moradorProvider.dart';
import 'package:rate_io/classes/repProvider.dart';
import 'firebase_options.dart'; // Para as opções de configuração do Firebase
import 'initialScreen.dart'; // Importa sua tela inicial
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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoradorProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RepProvider(),
        ),
      ],
      child: MyApp(), 
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;


    return MaterialApp(
      title: 'Rate.io',
      initialRoute: Routes.login,
      onGenerateRoute: Routes.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'K2D',
        scaffoldBackgroundColor: const Color(0xffefefef),
        appBarTheme: AppBarTheme(
          color: const Color(0x00B1B0B0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // Padding dinâmico
                textStyle: TextStyle(fontSize: screenWidth * 0.06), // Responsivo
                minimumSize: Size(screenWidth * 0.4, screenHeight * 0.05), // Botão
                foregroundColor: Color(0xFF497A9D))),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: const Color(0xFF497A9D), // Cor do texto da label
            fontSize: screenWidth * 0.06, // Responsivo
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
                color: Color(0xFF497A9D)), // Cor da linha quando em foco
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            minimumSize: Size(screenWidth * 0.5, screenHeight * 0.06), // Tamanho do botão
            textStyle: TextStyle(fontSize: screenWidth * 0.04), // Responsivo
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            textStyle: TextStyle(fontSize: screenWidth * 0.04), // Responsivo
            fixedSize: Size(screenWidth * 0.7, screenHeight * 0.06), // Responsivo
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
          const InitialScreen(), // Tela inicial após o Firebase ser inicializado
    );
  }
}
