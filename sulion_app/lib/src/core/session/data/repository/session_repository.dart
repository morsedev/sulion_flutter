import 'dart:convert';
import 'dart:developer';

import 'package:sulion_app/src/core/session/data/model/login_request_model.dart';
import 'package:sulion_app/src/core/session/data/model/session_info_model.dart';
import 'package:sulion_app/src/core/session/domain/entity/login_entity.dart';
import 'package:sulion_app/src/core/session/domain/entity/session_info_entity.dart';
import 'package:sulion_app/src/core/session/domain/repository/session_repository.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/infra/client.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';
import 'package:sulion_app/src/shared/infra/local_datasource.dart';

class SessionRepositoryImpl implements SessionRepository {
  const SessionRepositoryImpl(this._remoteDatasource, this._localDatasource);

  final Client _remoteDatasource;
  final LocalDatasource _localDatasource;

  @override
  Future<ResultHolder<SessionInfoEntity, ErrorModel>> login(
      LoginEntity entity) async {
    final request = LoginRequestModel.fromEntity(entity);

    var respuesta = await _remoteDatasource.login(request.toJson());
    if (respuesta.statusCode == 200) {
      // var encoded = jsonDecode(respuesta.body) as Map<String, dynamic>;
      var sessionInfo = SessionInfoModel.fromJson(null, respuesta.body);
      var sessionEntity = SessionInfoEntity(
        token: sessionInfo.token,
        refreshToken: sessionInfo.refreshToken,
        expiration: sessionInfo.expiration,
      );
      return ResultHolder.success(sessionEntity);
    }
    return ResultHolder.fail(
      const ErrorModel(
        code: 'fallo',
        message: 'Algo ha fallado',
      ),
    );
  }

  @override
  Future<ResultHolder<SessionInfoEntity, ErrorModel>> refreshToken(
      SessionInfoEntity tokenInfo) async {
    var response = await _remoteDatasource.refreshToken(
      SessionInfoModel(
              token: tokenInfo.token ?? '',
              refreshToken: tokenInfo.refreshToken ?? '',
              expiration: tokenInfo.expiration ?? 0)
          .toJson(),
    );
    if (response.statusCode == 200) {
      var sessionInfo = SessionInfoModel.fromJson(null, response.body);
      var sessionEntity = SessionInfoEntity(
        token: sessionInfo.token,
        refreshToken: sessionInfo.refreshToken,
        expiration: sessionInfo.expiration,
      );
      return ResultHolder.success(sessionEntity);
    }
    return ResultHolder.fail(
      const ErrorModel(
        code: 'fallo',
        message: 'Algo ha fallado',
      ),
    );
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
      log('Session saved ${jsonEncode(sessionInfo.toStorage())}');
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
