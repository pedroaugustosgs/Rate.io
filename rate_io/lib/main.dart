import 'initialScream.dart';
import 'package:flutter/material.dart';

void main(){
   runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rate.io',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xffefefef),
        appBarTheme: AppBarTheme(
          color: Color(0x00B1B0B0)
        )  
        ),
      home: InitialScream(), // Defina a tela inicial aqui
    );
  }
}