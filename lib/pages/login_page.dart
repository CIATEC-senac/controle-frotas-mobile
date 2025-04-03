import 'dart:developer';

import 'package:alfaid/api/api.dart';
import 'package:alfaid/widgets/login_textfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // Cria o estado para o widget LoginScreen
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String cpf = '';
  String password = '';

  // Estado para controlar a visibilidade da senha
  bool isPasswordVisible = false;

  void login() async {
    API().login(cpf, password).then((token) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      preferences.setString('token', token);

      Navigator.of(context).pushReplacementNamed('/home');
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context)
              .size
              .width, // Define a largura do container para ocupar toda a tela
          height: MediaQuery.of(context)
              .size
              .height, // Define a altura do container para ocupar toda a tela

          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            spacing: 80,
            children: [
              Spacer(),
              SizedBox(
                width: 200,
                child: Image.asset('assets/images/logo.png'),
              ),
              Spacer(),
              Column(
                spacing: 16,
                children: [
                  _buildCpfField(), // Campo de CPF
                  _buildPasswordField(), // Campo de senha
                  _buildForgotPasswordButton(), // Botão "Esqueci minha senha"
                  _buildLoginButton(), // Botão de login
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  // Campo de entrada para o CPF
  Widget _buildCpfField() {
    return LoginTextField(
      keyboardType: TextInputType.number,
      prefixIcon: Icons.person, // Ícone de pessoa
      labelText: 'Usuário (CPF)', // Texto do rótulo
      onChanged: (value) => setState(() {
        cpf = value;
      }),
      value: cpf,
    );
  }

  // Campo de entrada para a senha
  Widget _buildPasswordField() {
    return LoginTextField(
      obscureText: !isPasswordVisible, // Controla a visibilidade da senha
      prefixIcon: Icons.lock,
      suffixIcon: IconButton(
        icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(() {
            isPasswordVisible =
                !isPasswordVisible; // Alterna a visibilidade da senha
          });
        },
      ),
      labelText: 'Senha', // Texto do rótulo
      onChanged: (value) => setState(() {
        password = value;
      }),
      value: password,
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
        ),
      ),
    );
  }

  // Botão de login
  Widget _buildLoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(
          double.infinity,
          50,
        ), // Largura completa e altura fixa
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Bordas arredondadas
        ),
      ),
      onPressed: login,
      child: const Text('Login'),
    );
  }
}
