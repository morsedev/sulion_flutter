import 'package:sulion_app/src/core/session/domain/entity/login_entity.dart';
import 'package:sulion_app/src/core/session/domain/repository/session_repository.dart';
import 'package:sulion_app/src/core/session/domain/use_case/login_use_case.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';

class LoginUseCaseImpl implements LoginUseCase {
  LoginUseCaseImpl(this._repository);
  final SessionRepository _repository;

  @override
  Future<ResultHolder<bool, ErrorModel>> call(LoginEntity param) async {
    var value = await _repository
        .login(LoginEntity(username: param.username, password: param.password));

    return value;
  }
}
