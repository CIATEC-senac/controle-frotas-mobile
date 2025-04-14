import 'package:alfaid/api/api.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'pages/login_page.dart'; // Importa a tela de login
import 'pages/home_page.dart'; // Importa a página HomePage

// Função principal que inicia o aplicativo
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await API().getToken();

  String initialRoute = token != null ? '/home' : '/login';

  runApp(App(
    initialRoute: initialRoute,
  )); // Inicia o widget raiz do aplicativo
}

// Widget raiz do aplicativo
class App extends StatelessWidget {
  final String initialRoute;

  const App({
    super.key,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Desativa o banner de depuração
        title: 'ALFAID Frotas', // Título do aplicativo

        // Define rotas nomeadas para navegação
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
        },
        // Define a rota inicial como a tela de login
        initialRoute: initialRoute,
        theme: ThemeData(
          // scaffoldBackgroundColor: Colors.grey[850],
          // colorScheme: colorScheme,
          //   cardTheme: const CardTheme(
          //     color: Color(0xFF424242),
          //   ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 241, 237, 237),
          textTheme: const TextTheme(
            headlineSmall:
                TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            bodySmall: TextStyle(fontSize: 14.0),
          ),
          //   iconTheme: IconThemeData(
          //     color: Colors.white,
          //   ),
          //   iconButtonTheme: IconButtonThemeData(
          //     style: ButtonStyle(
          //       iconColor: WidgetStateProperty.resolveWith<Color?>(
          //         (Set<WidgetState> states) {
          //           if (!states.contains(WidgetState.error) &&
          //               !states.contains(WidgetState.disabled)) {
          //             return Colors.white;
          //           }

          //           return null; // Use the component's default.
          //         },
          //       ),
          //       backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          //         (Set<WidgetState> states) {
          //           if (states.contains(WidgetState.pressed)) {
          //             return Colors.white.withValues(alpha: 0.1);
          //           }

          //           return null; // Use the component's default.
          //         },
          //       ),
          //     ),
          //   ),
        ),
      ),
    );
  }
}
