import 'package:flutter/widgets.dart';
import 'package:sulion_app/src/di/di_widget.dart';
import 'package:sulion_app/src/di/login/login_di.dart';
import 'package:sulion_app/src/feature/session/page/login_page.dart';
import 'package:sulion_app/src/plugs/login/login_plug.dart';

abstract class Dependency {}

class LoginDiWidget extends DiWidget<LoginPage, LoginDependency> {
  LoginDiWidget({super.key, required NavigatorState navigator})
      : super(
          dependency: DefaultLoginDependency(navigator: navigator),
          plug: const LoginPlug(),
        );
}
