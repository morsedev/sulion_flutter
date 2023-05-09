import 'package:sulion_app/src/app/domain/entity/refresh_token_request.dart';
import 'package:sulion_app/src/app/domain/entity/refresh_token_response.dart';
import 'package:sulion_app/src/app/domain/repository/session_repository.dart';
import 'package:sulion_app/src/core/shared/domain/use_case/base_use_case.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';

abstract class RefreshTokenUseCase
    extends BaseUseCase<RefreshTokenResponse, RefreshTokenRequest> {
  RefreshTokenUseCase(this._sessionRepository);
  final SessionRepository _sessionRepository;
  @override
  Future<ResultHolder<RefreshTokenResponse, ErrorModel>> call(
      RefreshTokenRequest param);
}
