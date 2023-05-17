import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

final staticHandler = createStaticHandler('images');

final _staticRouter = Router()..get('/<file|.*>', staticHandler);

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/login', _loginHandler)
  ..post('/login', _loginHandler)
  ..get('/products', _productsHandler)
  ..get('/products/<id>', _productsHandler)
  ..get('/products/<id>/<elements>', _productsHandler)
  ..mount('/images', _staticRouter);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

Future<Response> _loginHandler(Request request) async {
  try {
    final body = await request.readAsString();
    print(body);
    Map<String, dynamic> bodyDecoded = jsonDecode(body);
    if (bodyDecoded['username'] != null && bodyDecoded['password'] != null) {
      final minutesToExpire = Duration(minutes: 1);
      final loginOk = {
        'token': "token",
        'refreshToken': 'refresh_token',
        'expiration': DateTime.now().millisecondsSinceEpoch +
            minutesToExpire.inMilliseconds /* expira dentro de 6 minutos */
      };
      final encodedLoginOk = jsonEncode(loginOk);
      return Response.ok(encodedLoginOk);
    }
    return Response.badRequest();
  } catch (e) {
    return Response.badRequest();
  }
}

Future<Response> _productsHandler(Request request) async {
  final jsonFile =
      await File('${Directory.current.path}/bin/json/products/products.json')
          .readAsString();
  final List<dynamic> products = jsonDecode(jsonFile);
  // final body = await request.readAsString();
  final productId = request.params['id'];
  final elements = request.params['elements'];
  if (productId != null && elements != null) {
    final index = products.indexWhere(
        (element) => (element as Map<String, dynamic>)['name'] == productId);
    if (index > -1 && products.length >= index + 1) {
      final nextPageProducts = products
          .getRange(
              index + 1,
              products.length >= index + 1 + int.parse(elements)
                  ? index + 1 + int.parse(elements)
                  : products.length)
          .toList();
      return Response.ok(jsonEncode(nextPageProducts));
    } else {
      return Response.ok(jsonEncode([]));
    }
  } else if (productId != null) {
    try {
      final product =
          products.firstWhere((element) => element['name'] == productId);
      return Response.ok(jsonEncode(product));
    } on StateError catch (e) {
      print(e);
      return Response.notFound(null);
    } catch (e) {
      print(e);
    }
  }
  print('return products');
  return Response.ok(jsonEncode(products));
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
