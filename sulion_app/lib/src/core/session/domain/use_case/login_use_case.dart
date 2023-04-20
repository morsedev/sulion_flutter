import 'package:sulion_app/src/core/session/domain/entity/login_entity.dart';
import 'package:sulion_app/src/core/session/domain/repository/session_repository.dart';
import 'package:sulion_app/src/core/shared/domain/use_case/base_use_case.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';

abstract class LoginUseCase extends BaseUseCase<bool, LoginEntity> {
  LoginUseCase(this._repository);
  final SessionRepository _repository;

  @override
  Future<ResultHolder<bool, ErrorModel>> call(LoginEntity param);
}
