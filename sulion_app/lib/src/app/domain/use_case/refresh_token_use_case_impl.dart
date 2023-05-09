import 'package:sulion_app/src/app/domain/entity/refresh_token_response.dart';
import 'package:sulion_app/src/app/domain/entity/refresh_token_request.dart';
import 'package:sulion_app/src/app/domain/repository/session_repository.dart';
import 'package:sulion_app/src/app/domain/use_case/refresh_token_use_case.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';

class RefreshTokenUseCaseImpl implements RefreshTokenUseCase {
  RefreshTokenUseCaseImpl(this._sessionRepository);
  final SessionRepository _sessionRepository;
  @override
  Future<ResultHolder<RefreshTokenResponse, ErrorModel>> call(
      RefreshTokenRequest param) {
    return _sessionRepository.refreshToken(param);
  }
}
