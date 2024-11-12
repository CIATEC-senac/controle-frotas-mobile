import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importa a tela de login

// Função principal que inicia o aplicativo
void main() {
  runApp(const MyApp()); // Inicia o widget raiz do aplicativo
}

// Widget raiz do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Desativa o banner de depuração
      // Título do aplicativo, exibido em alguns lugares no sistema
      title: 'AlfaID',

      // Define o tema do aplicativo, incluindo o esquema de cores primárias
      theme: ThemeData(
        primarySwatch:
            Colors.blue, // Define um esquema de cores baseado em azul
      ),

      // Define a tela inicial do aplicativo como a LoginScreen
      home: const LoginScreen(),
    );
  }
}
