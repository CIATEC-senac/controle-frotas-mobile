import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String? _selectedCentroDeCusto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgalfaid.png'),
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
                    height: 80), // Ajusta a posição para ver o "AlfaID"
                _buildCpfField(),
                const SizedBox(height: 16),
                _buildPasswordField(),
                const SizedBox(height: 16),
                _buildCentroDeCustoDropdown(),
                const SizedBox(height: 16),
                _buildForgotPasswordButton(),
                const SizedBox(height: 32),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
      onPressed: () {
        // TODO: Implementar a funcionalidade de login
      },
      child: const Text('Login'),
    );
  }
}
