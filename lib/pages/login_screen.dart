// Importações necessárias para a aplicação Flutter, incluindo pacotes de material e http.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';

// A classe principal do widget de tela de login, que herda de StatefulWidget para possibilitar atualizações de estado.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState(); // Criação do estado da tela de login.
}

// A classe de estado para LoginScreen, que gerencia o comportamento da interface.
class _LoginScreenState extends State<LoginScreen> {
  // Controladores para os campos de CPF e senha, usados para pegar e manipular os valores dos inputs.
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variável booleana para controlar a visibilidade da senha.
  bool _isPasswordVisible = false;

  // Variável para armazenar o valor selecionado do campo de "Centro de Custo".
  String? _selectedCentroDeCusto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A tela de login tem um container com uma imagem de fundo que se ajusta à tela.
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgalfaid.png'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                _buildCpfField(), // Campo de CPF.
                const SizedBox(height: 16),
                _buildPasswordField(), // Campo de senha.
                const SizedBox(height: 16),
                _buildCentroDeCustoDropdown(), // Dropdown de Centro de Custo.
                const SizedBox(height: 16),
                _buildForgotPasswordButton(), // Botão de 'Esqueci minha senha'.
                const SizedBox(height: 32),
                _buildLoginButton(), // Botão de login.
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para criar o campo de texto de CPF.
  Widget _buildCpfField() {
    return TextField(
      controller: _cpfController,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person, color: Colors.white),
        labelText: 'Usuário (CPF)',
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

  // Método para criar o campo de senha com opção de visualizar/esconder a senha.
  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: () {
            // Altera o estado de visibilidade da senha ao clicar no ícone.
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        labelText: 'Senha',
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

  // Método para criar o campo de seleção de "Centro de Custo" usando Dropdown.
  Widget _buildCentroDeCustoDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCentroDeCusto,
      items: const [
        DropdownMenuItem(
          value: 'Centro 1',
          child: Text('Homologação', style: TextStyle(color: Colors.white)),
        ),
        DropdownMenuItem(
          value: 'Centro 2',
          child: Text('Fábrica', style: TextStyle(color: Colors.white)),
        ),
        // Outros centros de custo são listados aqui.
      ],
      onChanged: (value) {
        // Atualiza o centro de custo selecionado.
        setState(() {
          _selectedCentroDeCusto = value;
        });
      },
      dropdownColor: const Color.fromARGB(255, 44, 44, 44),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.settings, color: Colors.white),
        labelText: 'Selecione o Centro de Custo',
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

  // Método que cria o botão de recuperação de senha.
  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          // TODO: Implementar recuperação de senha.
        },
        child: const Text(
          'Esqueci minha senha',
          style: TextStyle(color: Color.fromARGB(255, 88, 104, 196)),
        ),
      ),
    );
  }

  // Método que cria o botão de login.
  Widget _buildLoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: const Color.fromARGB(255, 43, 42, 112),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: _login, // Chama a função de login quando pressionado.
      child: const Text('Entrar'),
    );
  }

  // Função de login que valida o CPF e a senha e realiza a autenticação.
  Future<void> _login() async {
    String cpf = _cpfController.text.trim();
    String senha = _passwordController.text.trim();

    // Verifica se os campos de CPF e senha não estão vazios.
    if (cpf.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    try {
      // Realiza uma requisição HTTP para obter a lista de usuários.
      final response = await http.get(Uri.parse('http://localhost:3000/users'));

      if (response.statusCode == 200) {
        // Converte a resposta JSON em lista de usuários.
        List<dynamic> users = jsonDecode(response.body);

        // Busca um usuário que tenha o CPF e senha correspondentes.
        final user = users.firstWhere(
          (u) => u['cpf'] == cpf && u['senha'] == senha,
          orElse: () => null,
        );

        // Se o usuário for encontrado, navega para a página inicial.
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          // Caso contrário, exibe uma mensagem de erro.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('CPF ou senha incorretos')),
          );
        }
      } else {
        // Exibe mensagem caso haja erro na requisição.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao buscar usuários')),
        );
      }
    } catch (e) {
      // Trata erros de conexão e exibe uma mensagem.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro de conexão: $e')),
      );
    }
  }
}