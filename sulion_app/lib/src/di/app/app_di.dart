import 'package:sulion_app/src/app/app_view_model.dart';
import 'package:sulion_app/src/core/session/data/repository/session_repository.dart';
import 'package:sulion_app/src/core/session/domain/use_case/refresh_token_use_case_impl.dart';
import 'package:sulion_app/src/di/di.dart';
import 'package:sulion_app/src/shared/infra/client.dart';
import 'package:sulion_app/src/shared/infra/local_datasource.dart';

abstract class AppDependency implements Dependency {
  const AppDependency();
  AppViewModel get appViewModel;
}

class DefaultAppDependency implements AppDependency {
  DefaultAppDependency();
  @override
  final AppViewModel appViewModel = AppViewModel(RefreshTokenUseCaseImpl(
      SessionRepositoryImpl(ClientImpl(), LocalDatasourceImpl())));
}
