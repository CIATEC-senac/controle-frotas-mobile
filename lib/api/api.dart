import 'dart:convert';

import 'package:alfaid/models/route.dart';
import 'package:alfaid/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class API {
  final String baseUrl =
      "https://fbe5-2804-1b3-c2c3-e266-55f2-8d6a-6587-cdea.ngrok-free.app";

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token');
  }

  Future<T> _handler<T>(http.Response response) async {
    if (response.statusCode <= 400) {
      return json.decode(response.body) as T;
    } else {
      throw Exception(
          'Failed to GET ${response.request?.url.toString()}: ${response.body}');
    }
  }

  Future<T> _get<T>(String url) async {
    String? token = await getToken();

    return _handler(await http.get(Uri.parse('$baseUrl$url'), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    }));
  }

  Future<T> _post<T>(
    String url, {
    Object? body,
  }) async {
    String? token = await getToken();

    return _handler(await http.post(Uri.parse('$baseUrl$url'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode(body)));
  }

  Future<UserModel> fetchUser(int id) async {
    return _get('/user/$id').then((raw) {
      return UserModel.fromJson(raw);
    });
  }

  Future<RouteModel> fetchRoute(int id) async {
    Map<String, dynamic> raw = json.decode(
        '{"id": 1, "origem": "Rua tal", "destino": "Rua tal tal", "totalParadas": 15, "distancia": 27, "tempoEstimado": 75}');

    return RouteModel.fromJson(raw);
  }

  Future<String> login(String cpf, String pass) async {
    var body = {'cpf': cpf, 'senha': pass};

    return _post('/auth/login', body: body).then((response) {
      return response['access_token'].toString();
    });
  }
}
