import 'package:flutter/material.dart'; // Para widgets do Flutter
import 'package:firebase_core/firebase_core.dart'; // Para inicializar o Firebase
import 'firebase_options.dart'; // Para as opções de configuração do Firebase
import 'initialScream.dart'; // Importa sua tela inicial

void main() async {
  // Assegura que os widgets do Flutter estão inicializados antes de usar
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xffefefef),
        appBarTheme: const AppBarTheme(
          color: Color(0x00B1B0B0),
        ),
      ),
      home: const InitialScream(), // Tela inicial após o Firebase ser inicializado
    );
  }
}
