import 'package:flutter/material.dart';
import 'pages/login_screen.dart'; // Importa a tela de login
import 'pages/home_page.dart'; // Importa a página HomePage

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
      title: 'AlfaID', // Título do aplicativo

      // Define rotas nomeadas para navegação
      routes: {
        '/login': (context) => const LoginScreen(), // Tela de login
        '/home': (context) => HomePage(), // Tela HomePage
      },

      // Define a rota inicial como a tela de login
      initialRoute: '/login',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define o tema primário do aplicativo
      ),
    );
  }
}
