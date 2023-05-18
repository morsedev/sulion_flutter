import 'package:sulion_app/src/core/session/domain/entity/session_info_entity.dart';
import 'package:sulion_app/src/shared/infra/client.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';
import 'package:sulion_app/src/shared/infra/local_datasource.dart';

import '../entity/login_entity.dart';

abstract class SessionRepository {
  const SessionRepository(
    Client remoteDatasource,
    LocalDatasource localDatasource,
  );
  Future<ResultHolder<SessionInfoEntity, ErrorModel>> login(
      LoginEntity loginData);
  Future<ResultHolder<SessionInfoEntity, ErrorModel>> refreshToken(
      SessionInfoEntity tokenInfo);
  Future<ResultHolder<SessionInfoEntity, ErrorModel>> getSessionInfo();
  Future<ResultHolder<bool, ErrorModel>> saveSessionInfo(
      SessionInfoEntity sessionInfo);
}
