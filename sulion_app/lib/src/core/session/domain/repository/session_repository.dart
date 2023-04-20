import 'package:sulion_app/src/shared/infra/client.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';

import '../entity/login_entity.dart';

abstract class SessionRepository {
  const SessionRepository(
    this._datasource,
  );
  final Client _datasource;
  Future<ResultHolder<bool, ErrorModel>> login(LoginEntity loginData);
}
