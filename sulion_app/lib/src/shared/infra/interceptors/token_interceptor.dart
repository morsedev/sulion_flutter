import 'package:sulion_app/src/core/session/domain/entity/session_info_entity.dart';
import 'package:sulion_app/src/core/session/domain/repository/session_repository.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';
import 'package:sulion_app/src/shared/infra/interceptors/interceptor.dart';

abstract class TokenInterceptor
    implements Interceptor<Future<InterceptorResponse>> {
  @override
  Future<InterceptorResponse> call(InterceptorRequest request);
}

class TokenInterceptorImpl implements TokenInterceptor {
  const TokenInterceptorImpl(this._sessionRepository);
  final SessionRepository _sessionRepository;
  @override
  Future<InterceptorResponse> call(InterceptorRequest request) async {
    ResultHolder<SessionInfoEntity, ErrorModel> getSessionInfoResponse =
        await _sessionRepository.getSessionInfo();
    switch (getSessionInfoResponse.result) {
      case Result.succeed:
        final sessionInfo = getSessionInfoResponse.successData;
        if (sessionInfo?.token != null) {
          var newHeaders = request.headers;
          newHeaders['token'] = sessionInfo!.token!;
          return InterceptorResponse(headers: newHeaders);
        } else {
          return InterceptorResponse(headers: request.headers);
        }
      case Result.failed:
        return InterceptorResponse(headers: request.headers);
    }
  }
}
