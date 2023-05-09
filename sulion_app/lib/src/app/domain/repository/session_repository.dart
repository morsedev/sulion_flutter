import 'package:sulion_app/src/app/domain/entity/refresh_token_request.dart';
import 'package:sulion_app/src/app/domain/entity/refresh_token_response.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';

abstract class SessionRepository {
  Future<ResultHolder<RefreshTokenResponse, ErrorModel>> refreshToken(
      RefreshTokenRequest tokenInfo);
}
