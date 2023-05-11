import 'dart:async';

import 'package:sulion_app/src/core/session/domain/entity/session_info_entity.dart';
import 'package:sulion_app/src/core/session/domain/repository/session_repository.dart';
import 'package:sulion_app/src/core/session/domain/use_case/refresh_token_use_case.dart';
import 'package:sulion_app/src/core/shared/types/none.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';

class RefreshTokenUseCaseImpl implements RefreshTokenUseCase {
  RefreshTokenUseCaseImpl(this._sessionRepository);
  final SessionRepository _sessionRepository;
  final StreamController<ResultHolder<SessionInfoEntity, ErrorModel>>
      _streamController = StreamController();
  @override
  Stream<ResultHolder<SessionInfoEntity, ErrorModel>> call([None? param]) {
    // return _sessionRepository.refreshToken(param);
    _sessionRepository.getSessionInfo().then((sessionInfoResult) {
      switch (sessionInfoResult.result) {
        case Result.succeed:
          final sessionResult = sessionInfoResult.successData;
          if (sessionResult != null &&
              sessionResult.expiration != null &&
              sessionResult.refreshToken != null) {
            final currentTime = DateTime.now().millisecondsSinceEpoch;
            final expirationTime = sessionResult.expiration!;
            const tresHold = 30 * 1000;
            final durationMilliseconds =
                (expirationTime - currentTime) - tresHold;

            Timer(Duration(milliseconds: durationMilliseconds), () async {
              final refresTokenResponse = await _sessionRepository
                  .refreshToken(sessionResult.refreshToken!);
              switch (refresTokenResponse.result) {
                case Result.succeed:
                  if (refresTokenResponse.successData != null) {
                    _sessionRepository
                        .saveSessionInfo(refresTokenResponse.successData!);
                    _streamController.add(
                        ResultHolder.success(refresTokenResponse.successData!));
                  }
                  break;
                case Result.failed:
                  // TODO: Handle this case.
                  break;
              }
            });
          }
          break;
        case Result.failed:
          // TODO: Handle this case.
          break;
      }
    });

    return _streamController.stream;
  }
}
