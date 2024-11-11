import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores para os campos de CPF e Senha
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variável para controlar a visibilidade da senha (exibir ou ocultar)
  bool _isPasswordVisible = false;

  // Variável para armazenar a seleção no campo de Centro de Custo
  String? _selectedCentroDeCusto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Define a cor de fundo da tela
      backgroundColor: const Color.fromARGB(255, 44, 44, 44),
      body: SingleChildScrollView(
        // Permite que a tela role caso o teclado seja aberto em dispositivos menores
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40), // Espaçamento do topo

              // Logo do aplicativo com fundo arredondado
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  // Definindo bordas arredondadas para o container da logo
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  'assets/banneralfaid.png', // Caminho da imagem da logo
                  width: MediaQuery.of(context).size.width * 0.8, // Largura ajustada da imagem
                  fit: BoxFit.contain, // Mantém a proporção da imagem
                ),
              ),

              const SizedBox(height: 32), // Espaçamento entre a logo e o campo de CPF
              _buildCpfField(), // Campo de entrada de CPF
              const SizedBox(height: 16), // Espaçamento entre o CPF e Senha
              _buildPasswordField(), // Campo de entrada de Senha
              const SizedBox(height: 16), // Espaçamento entre Senha e Centro de Custo
              _buildCentroDeCustoDropdown(), // Dropdown para seleção do Centro de Custo
              const SizedBox(height: 16), // Espaçamento entre Centro de Custo e botão Esqueci minha senha
              _buildForgotPasswordButton(), // Botão Esqueci minha senha
              const SizedBox(height: 32), // Espaçamento entre botão Esqueci minha senha e Login
              _buildLoginButton(), // Botão de Login
            ],
          ),
        ),
      ),
    );
  }

  // Método que retorna o campo de entrada de CPF
  Widget _buildCpfField() {
    return TextField(
      controller: _cpfController, // Controlador do campo
      keyboardType: TextInputType.number, // Define o teclado numérico
      style: const TextStyle(color: Colors.white), // Cor do texto digitado
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person, color: Colors.white), // Ícone de CPF
        labelText: 'Usuário (CPF)', // Texto do label do campo
        labelStyle: TextStyle(color: Colors.white), // Cor do label
        border: OutlineInputBorder(), // Estilo da borda
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Cor da borda quando não focado
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue), // Cor da borda quando focado
        ),
      ),
    );
  }

  // Método que retorna o campo de entrada de Senha
  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController, // Controlador do campo
      obscureText: !_isPasswordVisible, // Controla a visibilidade da senha
      style: const TextStyle(color: Colors.white), // Cor do texto digitado
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, color: Colors.white), // Ícone de senha
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off, // Ícone de visibilidade
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible; // Alterna a visibilidade da senha
            });
          },
        ),
        labelText: 'Senha', // Texto do label do campo
        labelStyle: const TextStyle(color: Colors.white), // Cor do label
        border: const OutlineInputBorder(), // Estilo da borda
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Cor da borda quando não focado
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue), // Cor da borda quando focado
        ),
      ),
    );
  }

  // Método que retorna o Dropdown para seleção de Centro de Custo
  Widget _buildCentroDeCustoDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCentroDeCusto, // Valor atual do dropdown
      items: const [
        // Definindo cada opção do dropdown com cor do texto branca
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
        // Atualiza o valor selecionado no dropdown
        setState(() {
          _selectedCentroDeCusto = value;
        });
      },
      dropdownColor: const Color.fromARGB(255, 44, 44, 44), // Cor de fundo do dropdown
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.settings, color: Colors.white), // Ícone do campo
        labelText: 'Selecione o Centro de Custo', // Texto do label do campo
        labelStyle: TextStyle(color: Colors.white), // Cor do label
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Cor da borda quando não focado
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue), // Cor da borda quando focado
        ),
      ),
    );
  }

  // Botão para "Esqueci minha senha"
  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          // TODO: Implementar a funcionalidade de recuperação de senha
        },
        child: const Text(
          'Esqueci minha senha',
          style: TextStyle(color: Color.fromARGB(255, 88, 104, 196)), // Cor do texto do botão
        ),
      ),
    );
  }

  // Botão de Login
  Widget _buildLoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50), // Largura total do botão
        backgroundColor: const Color.fromARGB(255, 43, 42, 112), // Cor de fundo do botão
        foregroundColor: Colors.white, // Cor do texto do botão
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Define bordas arredondadas
        ),
      ),
      onPressed: () {
        // TODO: Implementar a funcionalidade de login
      },
      child: const Text('Login'),
    );
  }
}
