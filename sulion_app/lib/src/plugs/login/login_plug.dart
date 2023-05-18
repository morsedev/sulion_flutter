import 'package:sulion_app/src/di/login/login_di.dart';
import 'package:sulion_app/src/feature/session/page/login_page.dart';

import '../plug.dart';

class LoginPlug implements Plug<LoginPage, LoginDependency> {
  const LoginPlug();
  @override
  LoginPage call(LoginDependency dependency) {
    return LoginPage(
      loginPressed: dependency.viewModel.doLogin,
      onUsernameChange: dependency.viewModel.usernameChanged,
      onPasswordChange: dependency.viewModel.passwordChanged,
    );
  }
}
