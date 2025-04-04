import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alfaid/models/route.dart';
import 'package:alfaid/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class API {
  final String baseUrl =
      "https://8e3f-2804-1b3-c2c0-282c-2ee7-1222-5992-e0f.ngrok-free.app";
  // Função para obter o token e armazenar no local
  Future<String?> getToken() async {
    // Obtem a instância SharedPreferences para acessar os dados armazenados
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Retorna o valor da armazenado na chave token
    return preferences.getString('token');
  }

  // Função genérica para lidar com respostas http
  Future<T> _handler<T>(http.Response response) async {
    // Verifica se a resposta da requisição indica sucesso
    if (response.statusCode <= 400) {
      // Converte e retorna o corpo da requisição json em um tipo generico T
      return json.decode(response.body) as T;
    } else {
      String message = switch (response.statusCode) {
        400 => 'Dados inválidos',
        401 => 'Não autorizado',
        403 => 'Sem permissão',
        404 => 'Não encontrado',
        _ => response.body,
      };

      throw Exception(message);
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    String? token = await getToken();

    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
  }

  // Método genérico para realizar requisições get
  Future<T> _get<T>(String url) async {
    return await http
        // Faz a requisição get para a url fornecida
        .get(Uri.parse('$baseUrl$url'), headers: await _getHeaders())
        .timeout(
          const Duration(seconds: 2),
          onTimeout: () => http.Response('Error', 408),
        )
        .then((response) => _handler<T>(response));
  }

  // Método genérico para realizar requisições post
  Future<T> _post<T>(
    String url, {
    // Recebe um corpo de requisição opcional
    Object? body,
  }) async {
    return _handler(
      await http
          .post(Uri.parse('$baseUrl$url'),
              // Adiciona os headers e serializa o corpo da requisição para json
              headers: await _getHeaders(),
              body: json.encode(body))
          .timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408);
        },
      ),
    );
  }

  // Método para buscar usuário pelo id
  Future<UserModel> fetchUser(int id) async {
    // Chama nossa função get para obter os dados do usuario
    return _get('/user/$id').then((raw) {
      // Converte a resposta json em um objeto UserModel
      return UserModel.fromJson(raw);
    });
  }

  Future<RouteModel> fetchRoute(int id) async {
    Map<String, dynamic> raw = json.decode(
        '{"id": 1, "origem": "Rua tal", "destino": "Rua tal tal", "totalParadas": 15, "distancia": 27, "tempoEstimado": 75}');

    return RouteModel.fromJson(raw);
  }

  // Método para realizar login com cpf e senha
  Future<String> login(String cpf, String pass) async {
    // Cria o corpo da requisição com cpf e senha
    var body = {'cpf': cpf, 'senha': pass};

    // Faz uma requisição post para autenticação
    return _post('/auth/login', body: body).then((response) {
      // Retorna o token de acesso da resposta
      return response['access_token'].toString();
    });
  }
}
