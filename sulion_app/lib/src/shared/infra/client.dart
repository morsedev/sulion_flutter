import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sulion_app/src/shared/infra/interceptor.dart';

abstract class Client {
  Future<http.Response> login(Map<String, dynamic> body);
  Future<http.Response> refreshToken(Map<String, dynamic> body);
  Future<http.Response> products([String? id, int elementos = 10]);
  Future<http.Response> product(String id);
  Future<http.Response> allProducts();
  void addInterceptor(Interceptor interceptor);
}

class ClientImpl implements Client {
  final List<Interceptor> _interceptors = [];
  @override
  Future<http.Response> login(Map<String, dynamic> body) {
    final encodedBody = jsonEncode(body);
    var headers = {'content-type': 'application/json'};
    return http.post(
      Uri.http(
        '192.168.50.221:8080',
        'login',
      ),
      headers: _intercept(InterceptorRequest(headers: headers)).headers,
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
      headers: _intercept(InterceptorRequest(headers: {})).headers,
    );
  }

  @override
  Future<http.Response> allProducts() {
    return http.get(
      Uri.http(
        '192.168.50.221:8080',
        'products',
      ),
      headers: _intercept(InterceptorRequest(headers: {})).headers,
    );
  }

  @override
  Future<http.Response> product(String id) {
    return http.get(
      Uri.http(
        '192.168.50.221:8080',
        'products/$id',
      ),
      headers: _intercept(InterceptorRequest(headers: {})).headers,
    );
  }

  @override
  Future<http.Response> refreshToken(Map<String, dynamic> body) {
    final encodedBody = jsonEncode(body);
    return http.post(
      Uri.http(
        '192.168.50.221:8080',
        'refreshToken',
      ),
      headers: _intercept(InterceptorRequest(headers: {})).headers,
      body: encodedBody,
    );
  }

  @override
  void addInterceptor(Interceptor interceptor) {
    _interceptors.add(interceptor);
  }

  InterceptorResponse _intercept(InterceptorRequest request) {
    var headers = request.headers;
    InterceptorResponse? interceptorResponse;
    _interceptors.forEach((interceptor) async {
      interceptorResponse =
          await interceptor(InterceptorRequest(headers: headers));
    });

    return interceptorResponse ?? InterceptorResponse(headers: request.headers);
  }
}
