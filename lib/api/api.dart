import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:alfaid/models/history.dart';
import 'package:alfaid/models/history_approval.dart';
import 'package:alfaid/models/route.dart';
import 'package:alfaid/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class API {
  final String baseUrl = "http://34.151.210.112:3000";

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
      print('### Response: ${response.body}');

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
  Future<UserModel> fetchUserFromToken() async {
    // Chama nossa função get para obter os dados do usuario
    // Converte a resposta json em um objeto UserModel
    return _get('/token').then((raw) => UserModel.fromJson(raw));
  }

  // Método para buscar usuário pelo id autenticado
  Future<UserModel> fetchUser(int id) async {
    // Chama nossa função get para obter os dados do usuario
    return _get('/user/$id').then((raw) => UserModel.fromJson(raw));
  }

  // Método para buscar rota pelo id
  Future<RouteModel> fetchRoute(int id) async {
    return _get('/route/$id').then((raw) => RouteModel.fromJson(raw));
  }

  // Método para buscar histórico de rota finalizada
  Future<List<RouteHistoryModel>> fetchRouteHistory() async {
    return _get<List<dynamic>>('/history/').then(
      (raw) => raw
          .map(
            (history) => RouteHistoryModel.fromJson(history),
          )
          .toList(),
    );
  }

  // Método para realizar login com cpf e senha
  Future<String> login(String cpf, String pass) async {
    // Cria o corpo da requisição com cpf e senha
    var body = {'cpf': cpf, 'password': pass};

    // Faz uma requisição post para autenticação
    // Retorna o token de acesso da resposta
    return _post('/auth/login', body: body).then(
      (response) => response['token'].toString(),
    );
  }

  Future<dynamic> createHistory(Map<String, dynamic> history) async {
    return _post('/history', body: history);
  }

  // Método para atualizar status de um histórico
  Future<void> updateHistoryStatus(
    int id,
    HistoryStatus status,
    String observation,
  ) {
    var apiStatus = switch (status) {
      HistoryStatus.approved => 0,
      HistoryStatus.disapproved => 1,
      HistoryStatus.pending => throw UnimplementedError(),
    };

    var body = {'status': apiStatus, 'observation': observation};

    return _post('/history/$id/status', body: body);
  }

  Future<String> getSignedUrl(String fileName, String contentType) {
    var body = {'fileName': fileName, 'contentType': contentType};

    return _post(
      '/history/upload/getSignedUrl',
      body: body,
    ).then((response) => response['signedUrl']);
  }

  Future<dynamic> uploadImage(
    String url,
    Uint8List bytes,
    String mimeType,
  ) async {
    return await http.put(
      Uri.parse(url),
      headers: {'Content-Type': mimeType},
      body: bytes,
    );
  }

  Future<dynamic> addUnplannedStop(Map<String, dynamic> unplannedStop) {
    return _post('/history/stop/unplanned', body: unplannedStop);
  }
}
