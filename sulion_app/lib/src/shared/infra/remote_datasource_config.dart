import 'package:sulion_app/src/core/session/data/repository/session_repository.dart';
import 'package:sulion_app/src/shared/infra/client.dart';
import 'package:sulion_app/src/shared/infra/interceptor.dart';
import 'package:sulion_app/src/shared/infra/local_datasource.dart';
import 'package:sulion_app/src/shared/infra/token_interceptor.dart';

class RemoteDatasourceConfig {
  Client bootstrap() {
    Client remoteDatasource = ClientImpl();
    LocalDatasource localDatasource = LocalDatasourceImpl();
    Interceptor tokenInterceptor = TokenInterceptorImpl(
      SessionRepositoryImpl(
        remoteDatasource,
        localDatasource,
      ),
    );
    remoteDatasource.addInterceptor(tokenInterceptor);

    return remoteDatasource;
  }
}
