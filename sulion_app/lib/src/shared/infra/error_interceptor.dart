import 'package:http/http.dart';
import 'package:sulion_app/src/shared/infra/interceptor.dart';

abstract class ErrorInterceptor implements Interceptor<Future<Response>> {
  @override
  Future<Response> call(InterceptorRequest request);
}

class ErroInterceptorImpl implements ErrorInterceptor {
  @override
  Future<Response> call(InterceptorRequest request) async {
    if (request.uri.isNull() && request.future.isNull()) {
      var response = await request.future!(request.uri!);
      if (response.statusCode >= 500) {
        // TODO: capturamos error y lo enviamos a el widget App.
      }
    }
    return Future.value(Response('body', 200));
  }
}

extension Notnull on Object? {
  bool isNull() {
    return this != null;
  }
}
