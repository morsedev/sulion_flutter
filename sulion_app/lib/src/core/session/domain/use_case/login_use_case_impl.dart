import 'package:sulion_app/src/core/session/domain/entity/login_entity.dart';
import 'package:sulion_app/src/core/session/domain/repository/session_repository.dart';
import 'package:sulion_app/src/core/session/domain/use_case/login_use_case.dart';
import 'package:sulion_app/src/core/session/domain/use_case/refresh_token_use_case.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';

class LoginUseCaseImpl implements LoginUseCase {
  LoginUseCaseImpl(this._repository, this._refreshTokenUseCase);
  final SessionRepository _repository;
  final RefreshTokenUseCase _refreshTokenUseCase;

  @override
  Future<ResultHolder<bool, ErrorModel>> call(LoginEntity param) async {
    try {
      var sessionInfoResponse = await _repository.login(LoginEntity(
        username: param.username,
        password: param.password,
      ));
      switch (sessionInfoResponse.result) {
        case Result.succeed:
          if (sessionInfoResponse.successData != null) {
            await _repository.saveSessionInfo(sessionInfoResponse.successData!);
            _refreshTokenUseCase();
          }
          return ResultHolder.success(true);
        case Result.failed:
          return ResultHolder.fail(const ErrorModel(
            code: 'code',
            message: 'message',
          ));
      }
    } catch (e) {
      return ResultHolder.fail(const ErrorModel(
        code: 'code',
        message: 'message',
      ));
    }
  }
}
