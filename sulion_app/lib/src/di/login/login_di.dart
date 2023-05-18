import 'package:flutter/widgets.dart';
import 'package:sulion_app/src/core/session/data/repository/session_repository.dart';
import 'package:sulion_app/src/core/session/domain/use_case/login_use_case_impl.dart';
import 'package:sulion_app/src/core/session/domain/use_case/refresh_token_use_case_impl.dart';
import 'package:sulion_app/src/di/di.dart';
import 'package:sulion_app/src/feature/session/view_model/login_view_model.dart';
import 'package:sulion_app/src/shared/infra/local_datasource.dart';
import 'package:sulion_app/src/shared/infra/remote_datasource_config.dart';

abstract class LoginDependency implements Dependency {
  const LoginDependency({required this.navigator});
  final NavigatorState navigator;
  LoginViewModel get viewModel;
}

final remoteDatasource = const RemoteDatasourceConfig().bootstrap();
final localDatasource = LocalDatasourceImpl();
final sessionRepository =
    SessionRepositoryImpl(remoteDatasource, localDatasource);
final refreshTokenUseCase = RefreshTokenUseCaseImpl(sessionRepository);
final loginUseCase = LoginUseCaseImpl(sessionRepository, refreshTokenUseCase);
final loginViewModel = LoginViewModel(loginUseCase: loginUseCase);

class DefaultLoginDependency implements LoginDependency {
  DefaultLoginDependency({required this.navigator});
  @override
  final NavigatorState navigator;
  @override
  get viewModel => loginViewModel..setNavigator(navigator);
}
