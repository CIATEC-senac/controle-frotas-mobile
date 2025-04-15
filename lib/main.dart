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
          scaffoldBackgroundColor: const Color.fromARGB(255, 241, 237, 237),
          textTheme: const TextTheme(
            headlineSmall:
                TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            bodySmall: TextStyle(fontSize: 14.0),
          ),
        ),
      ),
    );
  }
}
