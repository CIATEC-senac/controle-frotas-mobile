import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Backend {
  final String host = "http://localhost:3000";

  login(String cpf, String senha) async {
    final response = await http.post(Uri.parse("$host/auth/login"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'cpf': cpf, 'senha': senha}));

    // Verifica se a requisição foi bem-sucedida
    if (response.statusCode == 200) {
      // Decodifica a resposta JSON recebida
      dynamic body = json.decode(response.body);

      // Converte a lista de JSON para uma lista de objetos User
      String token = body['token'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      return token;
    } else {
      print(response.body);
      // Lança uma exceção caso a requisição não tenha sido bem-sucedida
      throw Exception('Erro ao verificar login');
    }
  }
}
