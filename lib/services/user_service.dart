import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserService {
  // URL base para a API onde os usuários são armazenados
  static const String baseUrl = 'http://localhost:3000/users';

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
  Future<User?> loginUser(String cpf, String senha, String setor) async {
    // Faz a requisição HTTP GET para pegar todos os usuários
    final response = await http.get(Uri.parse(baseUrl));

    // Verifica se a requisição foi bem-sucedida
    if (response.statusCode == 200) {
      // Decodifica a resposta JSON recebida
      List<dynamic> body = json.decode(response.body);
      
      // Converte a lista de JSON para uma lista de objetos User
      List<User> users = body.map((user) => User.fromJson(user)).toList();

      // Itera sobre os usuários para verificar se existe um que tenha CPF, senha e setor correspondentes
      for (var user in users) {
        if (user.cpf == cpf && user.senha == senha && user.setor == setor) {
          return user; // Se encontrado, retorna o usuário, indicando sucesso no login
        }
      }
      return null; // Caso não encontre, retorna null, indicando falha no login
    } else {
      // Lança uma exceção caso a requisição não tenha sido bem-sucedida
      throw Exception('Erro ao verificar login');
    }
  }
}
