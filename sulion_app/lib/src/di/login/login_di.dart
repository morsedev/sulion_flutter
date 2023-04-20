import 'package:sulion_app/src/di/di.dart';
import 'package:sulion_app/src/feature/session/view_model/login_view_model.dart';

abstract class LoginDependency implements Dependency {
  const LoginDependency({required this.viewModel});
  final LoginViewModel viewModel;
}

class DefaultLoginDependency implements LoginDependency {
  const DefaultLoginDependency({required this.viewModel});
  @override
  final LoginViewModel viewModel;
}
