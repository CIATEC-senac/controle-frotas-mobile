import 'package:flutter/material.dart';
import 'pages/login_page.dart'; // Importa a tela de login
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
      title: 'ALFAID Frotas', // Título do aplicativo

      // Define rotas nomeadas para navegação
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomePage(),
      },
      // Define a rota inicial como a tela de login
      initialRoute: '/login',
      theme: ThemeData(
        cardTheme: const CardTheme(
          color: Color(0xFF424242),
        ),
        scaffoldBackgroundColor: const Color(0xFF303030),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
          ),
          bodySmall: TextStyle(
            fontSize: 14.0,
            color: Color(0xFFFFFFFF),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFFFFFFFF),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (!states.contains(WidgetState.error) &&
                    !states.contains(WidgetState.disabled)) {
                  return Color(0xFFFFFFFF);
                }

                return null; // Use the component's default.
              },
            ),
            backgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return Color(0xFFFFFFFF).withValues(alpha: 0.1);
                }

                return null; // Use the component's default.
              },
            ),
          ),
        ),
      ),
    );
  }
}
