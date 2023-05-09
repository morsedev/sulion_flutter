import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class Client {
  Future<http.Response> login(Map<String, dynamic> body);
  Future<http.Response> refreshToken(Map<String, dynamic> body);
  Future<http.Response> products([String? id, int elementos = 10]);
  Future<http.Response> product(String id);
  Future<http.Response> allProducts();
}

class ClientImpl implements Client {
  @override
  Future<http.Response> login(Map<String, dynamic> body) {
    final encodedBody = jsonEncode(body);
    return http.post(
      Uri.http(
        '192.168.50.221:8080',
        'login',
      ),
      headers: {'content-type': 'application/json'},
      body: encodedBody,
    );
  }

  @override
  Future<http.Response> products([String? id, int elementos = 10]) {
    return http.get(
      Uri.http(
        '192.168.50.221:8080',
        'products/$id/$elementos',
      ),
    );
  }

  @override
  Future<http.Response> allProducts() {
    return http.get(
      Uri.http(
        '192.168.50.221:8080',
        'products',
      ),
    );
  }

  @override
  Future<http.Response> product(String id) {
    return http.get(
      Uri.http(
        '192.168.50.221:8080',
        'products/$id',
      ),
    );
  }

  @override
  Future<http.Response> refreshToken(Map<String, dynamic> body) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }
}
