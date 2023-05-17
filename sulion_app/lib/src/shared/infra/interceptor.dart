import 'dart:convert';

import 'package:http/http.dart';

abstract class Interceptor<ResponseType> {
  ResponseType call(InterceptorRequest request);
}

class InterceptorRequest {
  InterceptorRequest({required this.headers, this.uri, this.future, this.body});
  Uri? uri;
  final Map<String, String> headers;
  Map<String, dynamic>? body;
  Future<Response> Function(Uri,
      {Object? body, Encoding? encoding, Map<String, String>? headers})? future;
}

class InterceptorResponse {
  InterceptorResponse({this.uri, required this.headers});
  Uri? uri;
  final Map<String, String> headers;
}
