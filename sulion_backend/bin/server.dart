import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/login', _loginHandler)
  ..post('/login', _loginHandler)
  ..get('/products', _productsHandler)
  ..get('/products/<id>', _productsHandler);

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
      final loginOk = {'token': "example_token"};
      final encodedLoginOk = jsonEncode(loginOk);
      return Response.ok(encodedLoginOk);
    }
    return Response.badRequest();
  } catch (e) {
    return Response.badRequest();
  }
}

Future<Response> _productsHandler(Request request) async {
  const products = [
    {
      'name': 'duplo',
      'description':
          'Sint labore esse anim nulla enim consectetur laborum ullamco enim id dolor veniam culpa amet. Duis ullamco voluptate in mollit cupidatat magna ad do nulla sint non. Consequat sunt proident aliqua duis ut. Ut occaecat dolor sit consequat laborum do pariatur sunt Lorem officia ad. Minim amet velit elit labore occaecat tempor ipsum aliqua. Aliqua anim ad velit cillum consectetur consectetur duis et labore mollit cupidatat. Velit velit velit duis culpa reprehenderit eu anim eu laborum adipisicing.',
      'image': 'https://sulion.es/39183-home_default/duplo.jpg',
    },
    {
      'name': 'taro',
      'description':
          'Ea laboris aute non commodo. Amet Lorem esse nulla tempor dolor dolore nulla ea nostrud occaecat. Eu fugiat proident nostrud minim ipsum culpa irure aliquip eu dolore velit. Id proident aliquip in do cillum reprehenderit irure reprehenderit consectetur nulla excepteur. Duis voluptate in sint ut dolore est. Voluptate nisi cillum ipsum eiusmod nulla sit fugiat consectetur duis nulla. Velit eu enim proident ut tempor eu.',
      'image': 'https://sulion.es/39290-home_default/taro.jpg',
    },
    {
      'name': 'tonda',
      'description':
          'Irure ad aute eu magna cupidatat culpa amet culpa duis sit deserunt. Quis ad mollit ea et. Labore ex officia in commodo enim enim quis ut mollit ut. Pariatur sint consequat ullamco magna veniam est. Occaecat commodo in officia nisi eu veniam labore culpa exercitation nisi incididunt. Aliquip eiusmod amet do pariatur dolor sit aute sit elit occaecat ea. Occaecat excepteur est ea reprehenderit sit quis.',
      'image': 'https://sulion.es/39362-home_default/tonda.jpg',
    },
    {
      'name': 'robb',
      'description':
          'Irure cillum aliquip exercitation aliqua duis amet excepteur ullamco deserunt aliqua qui qui aliqua. Occaecat amet cupidatat laborum Lorem in tempor. Mollit occaecat est deserunt aute consequat labore fugiat culpa. Cillum Lorem cupidatat et et. Aliquip in quis exercitation ullamco qui voluptate.',
      'image': 'https://sulion.es/39359-home_default/robb.jpg',
    },
    {
      'name': 'baloo',
      'description':
          'Veniam culpa ut ad laboris minim ex. Eu est dolore commodo nisi do esse consectetur amet duis mollit eiusmod pariatur culpa. Laborum consectetur est voluptate nisi sit deserunt et. Irure do id elit dolor non elit. Consequat commodo esse qui proident adipisicing reprehenderit consectetur magna occaecat ad commodo. Incididunt non Lorem ex est laborum cillum est sit enim duis dolore non.',
      'image': 'https://sulion.es/39084-home_default/baloo.jpg',
    },
    {
      'name': 'nova-xxl',
      'description':
          'Lorem minim aliqua sit ullamco eiusmod consectetur non. Nulla excepteur excepteur sit sit minim excepteur aute et sit officia labore laborum. Excepteur anim anim sit anim irure ullamco enim reprehenderit occaecat. Do consequat non consectetur tempor irure dolore culpa ut ex proident. Cupidatat est cillum ad non. Officia fugiat amet dolore culpa sunt sit do Lorem esse commodo ipsum eu ea ullamco. Nulla occaecat ad elit et non occaecat ipsum ad.',
      'image': 'https://sulion.es/39343-home_default/nova-xxl.jpg',
    },
    {
      'name': 'nova',
      'description':
          'Duis consequat labore dolor esse velit consectetur pariatur laboris incididunt eu. Exercitation eu elit consectetur sunt laboris deserunt qui do aliqua aliqua do dolor. Deserunt eiusmod esse reprehenderit id ullamco reprehenderit. Irure pariatur mollit anim eiusmod incididunt eiusmod ipsum sunt dolor do. Culpa ad sit deserunt Lorem proident ipsum eu nisi commodo et deserunt nulla sit mollit.',
      'image': 'https://sulion.es/39336-home_default/nova.jpg',
    },
    {
      'name': 'balcony',
      'description':
          'Cillum est nostrud eu sunt. Veniam amet eiusmod dolor cillum anim ullamco do velit. Minim ea ut amet occaecat culpa non id exercitation officia. Quis labore laboris cupidatat nisi cupidatat velit amet eiusmod. Laboris minim ea cillum officia duis. Exercitation proident cupidatat officia magna id nulla reprehenderit voluptate enim amet excepteur. Reprehenderit nostrud culpa sint voluptate sit duis sit mollit laborum laboris elit sunt magna aliquip.',
      'image': 'https://sulion.es/39330-home_default/balcony.jpg',
    },
    {
      'name': 'balcony-xl',
      'description':
          'Sunt ea culpa ad eu ut labore anim sunt quis cupidatat excepteur sint adipisicing. Consequat minim sint ut nostrud ad ex sunt quis sint excepteur nostrud velit. Lorem ut irure Lorem in pariatur consectetur ea sunt voluptate pariatur ipsum dolor ullamco in. Aute ut non aliquip sunt sunt sint. Nostrud esse nisi in aliqua mollit est labore. Duis proident irure dolor occaecat sit culpa ea consectetur excepteur. Veniam adipisicing mollit dolore ullamco.',
      'image': 'https://sulion.es/39323-home_default/balcony-xl.jpg',
    },
    {
      'name': 'gull',
      'description':
          'Enim pariatur consequat ex est deserunt nulla sunt nostrud adipisicing dolore deserunt proident sit nostrud. Laborum anim consectetur tempor excepteur sit ullamco esse sunt amet pariatur incididunt cupidatat excepteur. Sint sit magna dolore sunt sit irure nisi enim voluptate excepteur eiusmod quis. Sunt aliqua officia pariatur consectetur dolor exercitation. Non ex ut ipsum irure enim ullamco reprehenderit cillum reprehenderit officia voluptate ut veniam do. Deserunt mollit ipsum magna aliquip officia tempor excepteur deserunt velit dolore amet cillum.',
      'image': 'https://sulion.es/39303-home_default/gull.jpg',
    },
  ];
  // final body = await request.readAsString();
  final productId = request.params['id'];
  if (productId != null) {
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
