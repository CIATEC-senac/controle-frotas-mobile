import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // Cria o estado para o widget LoginScreen
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _cpfController =
      TextEditingController(); // Controlador para o campo de CPF
  final TextEditingController _passwordController =
      TextEditingController(); // Controlador para o campo de senha

  bool _isPasswordVisible =
      false; // Estado para controlar a visibilidade da senha
  // String?
  //     _selectedCentroDeCusto; // Variável para armazenar o centro de custo selecionado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context)
            .size
            .width, // Define a largura do container para ocupar toda a tela
        height: MediaQuery.of(context)
            .size
            .height, // Define a altura do container para ocupar toda a tela

        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(color: Color.fromARGB(255, 61, 61, 61)),
        child: Column(
          spacing: 80,
          children: [
            // Image.asset(
            //   'assets/images/bgalfaid.png',
            //   width: MediaQuery.of(context).size.width,
            // ),
            Spacer(),
            Center(
              child: Column(
                spacing: 16,
                children: [
                  _buildCpfField(), // Campo de CPF
                  _buildPasswordField(), // Campo de senha
                  _buildForgotPasswordButton(), // Botão "Esqueci minha senha"
                  _buildLoginButton(), // Botão de login
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  // Campo de entrada para o CPF
  Widget _buildCpfField() {
    return TextField(
      controller: _cpfController,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person, color: Colors.white), // Ícone de pessoa
        labelText: 'Usuário (CPF)', // Texto do rótulo
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  // Campo de entrada para a senha
  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible, // Controla a visibilidade da senha
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon:
            const Icon(Icons.lock, color: Colors.white), // Ícone de cadeado
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible =
                  !_isPasswordVisible; // Alterna a visibilidade da senha
            });
          },
        ),
        labelText: 'Senha', // Texto do rótulo
        labelStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  // Botão "Esqueci minha senha"
  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          // TODO: Implementar a funcionalidade de recuperação de senha
        },
        child: const Text(
          'Esqueci minha senha',
          style: TextStyle(color: Color.fromARGB(255, 88, 104, 196)),
        ),
      ),
    );
  }

  // Botão de login
  Widget _buildLoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize:
            const Size(double.infinity, 50), // Largura completa e altura fixa
        backgroundColor:
            const Color.fromARGB(255, 43, 42, 112), // Cor de fundo do botão
        foregroundColor: Colors.white, // Cor do texto
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Bordas arredondadas
        ),
      ),
      onPressed: () {
        // Ação para fazer login e redirecionar para a HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
      child: const Text('Login'),
    );
  }
}
