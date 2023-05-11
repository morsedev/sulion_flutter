import 'package:sulion_app/src/core/session/domain/entity/session_info_entity.dart';
import 'package:sulion_app/src/shared/infra/client.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';
import 'package:sulion_app/src/shared/infra/local_datasource.dart';

import '../entity/login_entity.dart';

abstract class SessionRepository {
  const SessionRepository(this._remoteDatasource, this._localDatasource);
  final Client _remoteDatasource;
  final LocalDatasource _localDatasource;
  Future<ResultHolder<bool, ErrorModel>> login(LoginEntity loginData);
  Future<String> getUser();
  Future<ResultHolder<SessionInfoEntity, ErrorModel>> refreshToken(
      String refreshToken);
  Future<ResultHolder<SessionInfoEntity, ErrorModel>> getSessionInfo();
  Future<ResultHolder<bool, ErrorModel>> saveSessionInfo(
      SessionInfoEntity sessionInfo);
}
