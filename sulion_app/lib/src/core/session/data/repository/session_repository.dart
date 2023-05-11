import 'package:http/http.dart' hide Client;
import 'package:sulion_app/src/core/session/data/model/login_request_model.dart';
import 'package:sulion_app/src/core/session/domain/entity/login_entity.dart';
import 'package:sulion_app/src/core/session/domain/entity/session_info_entity.dart';
import 'package:sulion_app/src/core/session/domain/repository/session_repository.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/infra/client.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';
import 'package:sulion_app/src/shared/infra/local_datasource.dart';

class SessionRepositoryImpl implements SessionRepository {
  const SessionRepositoryImpl(this._remoteDatasource, this._localDatasource);

  @override
  final Client _remoteDatasource;
  final LocalDatasource _localDatasource;

  @override
  Future<ResultHolder<bool, ErrorModel>> login(LoginEntity entity) async {
    final request = LoginRequestModel.fromEntity(entity);

    var respuesta = await _remoteDatasource.login(request.toJson());
    if (respuesta.statusCode == 200) {
      return ResultHolder<bool, ErrorModel>.success(true);
    }
    return ResultHolder<bool, ErrorModel>.fail(
      const ErrorModel(
        code: 'fallo',
        message: 'Algo ha fallado',
      ),
    );
  }

  Future<String> getUser() {
    // Se llama a la base de datos... No sabemos cuanto tarda
    return Future(() => 'Juanito');
  }

  @override
  Future<ResultHolder<SessionInfoEntity, ErrorModel>> refreshToken(
      String tokenInfo) {
    // TODO: hacer llamada el endpoint de refreshToken
    throw UnimplementedError();
  }

  @override
  Future<ResultHolder<SessionInfoEntity, ErrorModel>> getSessionInfo() async {
    var instance = SessionInfoEntity();
    final response = await _localDatasource.get<SessionInfoEntity>(
        _SessionRepositoryConstants.sessionKey, instance);
    if (response != null) {
      return ResultHolder.success(response);
    }
    return ResultHolder.fail(
        const ErrorModel(code: 'code', message: 'message'));
  }

  @override
  Future<ResultHolder<bool, ErrorModel>> saveSessionInfo(
      SessionInfoEntity sessionInfo) async {
    final isSuccess = await _localDatasource.put<SessionInfoEntity>(
        _SessionRepositoryConstants.sessionKey, sessionInfo);
    if (isSuccess) {
      return ResultHolder.success(true);
    }
    return ResultHolder.fail(
      const ErrorModel(code: 'code', message: 'message'),
    );
  }
}

class _SessionRepositoryConstants {
  static const sessionKey = 'session';
}
