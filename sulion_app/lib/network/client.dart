import 'dart:convert';

import 'package:http/http.dart' as http;

class Client {
  Future<http.Response> login(Map<String, dynamic> body) {
    final encodedBody = jsonEncode(body);
    return http.post(
      Uri.http(
        'localhost:8080',
        'login',
      ),
      headers: {'content-type': 'application/json'},
      body: encodedBody,
    );
  }

  Future<http.Response> products() {
    return http.get(
      Uri.http(
        'localhost:8080',
        'products',
      ),
    );
  }

  Future<http.Response> product(String id) {
    return http.get(
      Uri.http(
        'localhost:8080',
        'products/$id',
      ),
    );
  }
}
