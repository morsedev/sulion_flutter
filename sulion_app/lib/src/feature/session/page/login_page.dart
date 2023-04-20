import 'package:flutter/material.dart';
import 'package:sulion_app/src/shared/base/page/base_page.dart';
import 'package:sulion_app/src/shared/widgets/widgets.dart';

class LoginPage extends BasePage {
  const LoginPage({
    super.key,
    required this.loginPressed,
    required this.onUsernameChange,
    required this.onPasswordChange,
  });
  final Function() loginPressed;
  final Function(String username) onUsernameChange;
  final Function(String password) onPasswordChange;

  // _onLoginPressed(BuildContext context) {
  //   if (_username != null && _password != null) {
  //     Client()
  //         .login({
  //           'username': _username,
  //           'password': _password,
  //         })
  //         .then((value) => Navigator.of(context)
  //             .push(MaterialPageRoute(builder: (context) => const HomePage())))
  //         .catchError((error) => _showLoginError(context));
  //   } else {
  //     _showFieldsEmptyError(context);
  //   }
  // }

  // _showError(BuildContext context, String title, String description) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(description),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: Navigator.of(context).pop,
  //             child: const Text('Aceptar'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // _showFieldsEmptyError(BuildContext context) {
  //   _showError(context, 'Upsss!', 'Debes introducir tu username y password');
  // }

  // _showLoginError(BuildContext context) {
  //   _showError(context, 'Ouch!',
  //       'Algo no fue bien, comprueba que tu username y password sean correctos');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.amber,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: onUsernameChange,
                decoration: const InputDecoration(hintText: 'usuario'),
              ),
              VerticalSpacer.regular(),
              TextField(
                obscureText: true,
                onChanged: onPasswordChange,
                decoration: const InputDecoration(hintText: 'contraseña'),
              ),
              VerticalSpacer.medium(),
              ElevatedButton(
                onPressed: loginPressed,
                child: const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
