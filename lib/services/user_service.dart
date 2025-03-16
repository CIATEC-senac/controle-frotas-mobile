import 'dart:convert';

import 'package:alfaid/http/backend.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserService {
  // URL base para a API onde os usuários são armazenados
  static const String baseUrl = 'http://localhost:3000/user';

  // Função para buscar todos os usuários do JSON Server
  Future<List<User>> fetchUsers() async {
    // Faz a requisição HTTP GET para pegar os dados de usuários
    final response = await http.get(Uri.parse(baseUrl));

    // Verifica se a requisição foi bem-sucedida
    if (response.statusCode == 200) {
      // Decodifica a resposta JSON recebida
      List<dynamic> body = json.decode(response.body);

      // Converte a lista de JSON para uma lista de objetos User
      return body.map((user) => User.fromJson(user)).toList();
    } else {
      // Lança uma exceção caso a requisição não tenha sido bem-sucedida
      throw Exception('Erro ao carregar usuários');
    }
  }

  // Função para verificar o login do usuário sem modificar o JSON
  Future<String> loginUser(String cpf, String senha) async {
    // Faz a requisição HTTP GET para pegar todos os usuários
    return Backend().login(cpf, senha);
  }
}
