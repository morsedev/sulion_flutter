import 'package:flutter/material.dart';
import 'package:sulion_app/src/core/session/domain/entity/login_entity.dart';
import 'package:sulion_app/src/core/session/domain/repository/session_repository.dart';
import 'package:sulion_app/src/core/session/domain/use_case/login_use_case.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';
import 'package:sulion_app/src/feature/product_list/page/product_list_page.dart';

class LoginViewModel {
  LoginViewModel({required this.loginUseCase, required this.navigator});
  final LoginUseCase loginUseCase;
  final NavigatorState navigator;
  String? username;
  String? password;

  doLogin() async {
    if (_validateData()) {
      var value = await loginUseCase(
        LoginEntity(username: username!, password: password!),
      );

      switch (value.result) {
        case Result.succeed:
          navigator.push(
              MaterialPageRoute(builder: (context) => const ProductListPage()));
          break;
        case Result.failed:
          // TODO: Manejar errores de servicio
          break;
      }
    } else {
      // TODO: Manejar errores de validación
    }
  }

  usernameChanged(String newValue) {
    username = newValue;
  }

  passwordChanged(String newValue) {
    password = newValue;
  }

  bool _validateData() {
    return username != null && password != null;
  }
}
