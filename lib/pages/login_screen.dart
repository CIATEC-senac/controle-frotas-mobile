import 'package:flutter/material.dart';
import 'home_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  String?
      _selectedCentroDeCusto; // Variável para armazenar o centro de custo selecionado

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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgalfaid.png'), // Imagem de fundo
            fit: BoxFit.cover,
            alignment: Alignment.topCenter, // Alinha a imagem no topo
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                    height: 80), // Espaço para visualizar a logo "AlfaID"
                _buildCpfField(), // Campo de CPF
                const SizedBox(height: 16),
                _buildPasswordField(), // Campo de senha
                const SizedBox(height: 16),
                _buildCentroDeCustoDropdown(), // Dropdown para selecionar o centro de custo
                const SizedBox(height: 16),
                _buildForgotPasswordButton(), // Botão "Esqueci minha senha"
                const SizedBox(height: 32),
                _buildLoginButton(), // Botão de login
              ],
            ),
          ),
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

  // Dropdown para seleção do centro de custo
  Widget _buildCentroDeCustoDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCentroDeCusto, // Valor selecionado no dropdown
      items: const [
        DropdownMenuItem(
          value: 'Centro 1',
          child: Text('Homologação', style: TextStyle(color: Colors.white)),
        ),
        DropdownMenuItem(
          value: 'Centro 2',
          child: Text('Fábrica', style: TextStyle(color: Colors.white)),
        ),
        DropdownMenuItem(
          value: 'Centro 3',
          child: Text('AlfaID', style: TextStyle(color: Colors.white)),
        ),
        DropdownMenuItem(
          value: 'Centro 4',
          child: Text('Montagem', style: TextStyle(color: Colors.white)),
        ),
        DropdownMenuItem(
          value: 'Centro 5',
          child: Text('GERDAUOB', style: TextStyle(color: Colors.white)),
        ),
        DropdownMenuItem(
          value: 'Centro 6',
          child: Text('AP', style: TextStyle(color: Colors.white)),
        ),
        DropdownMenuItem(
          value: 'Centro 7',
          child: Text('Motorista', style: TextStyle(color: Colors.white)),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedCentroDeCusto = value; // Atualiza o valor selecionado
        });
      },
      dropdownColor:
          const Color.fromARGB(255, 44, 44, 44), // Cor de fundo do dropdown
      decoration: const InputDecoration(
        prefixIcon:
            Icon(Icons.settings, color: Colors.white), // Ícone de configurações
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
  // Adicione esta função à classe _LoginScreenState
  Future<void> autenticarUsuario(String cpf, String senha) async {
    final url = Uri.parse('http://192.168.0.100:3000/auth/login'); // Substitua <SEU_BACKEND> pela URL do backend

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'cpf': cpf, 'senha': senha}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Login bem-sucedido: ${data['token']}');
        // Redireciona para a página inicial
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        print('Erro de login: ${response.statusCode}');
        // Mostre uma mensagem de erro ao usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro de login: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Erro de conexão: $e');
      // Mostre uma mensagem de erro ao usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro de conexão')),
      );
    }
  }

// Altere o botão de login para usar a função acima
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
        final cpf = _cpfController.text;
        final senha = _passwordController.text;

        if (cpf.isNotEmpty && senha.isNotEmpty) {
          autenticarUsuario(cpf, senha);
        } else {
          // Mostre uma mensagem de erro se os campos estiverem vazios
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Preencha todos os campos')),
          );
        }
      },
      child: const Text('Login'),
    );
  }
}
