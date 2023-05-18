import 'dart:async';
import 'dart:developer';

import 'package:sulion_app/src/core/session/domain/entity/session_info_entity.dart';
import 'package:sulion_app/src/core/session/domain/repository/session_repository.dart';
import 'package:sulion_app/src/core/session/domain/use_case/refresh_token_use_case.dart';
import 'package:sulion_app/src/core/shared/types/none.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';

class RefreshTokenUseCaseImpl implements RefreshTokenUseCase {
  static final RefreshTokenUseCaseImpl _instance =
      RefreshTokenUseCaseImpl._internal();
  factory RefreshTokenUseCaseImpl(SessionRepository sessionRepository) {
    _instance._sessionRepository = sessionRepository;
    return _instance;
  }
  RefreshTokenUseCaseImpl._internal();
  late SessionRepository _sessionRepository;
  final StreamController<ResultHolder<SessionInfoEntity, ErrorModel>>
      _streamController = StreamController();
  bool _refreshTokenStarted = false;
  @override
  Stream<ResultHolder<SessionInfoEntity, ErrorModel>> call([None? param]) {
    // return _sessionRepository.refreshToken(param);
    if (!_refreshTokenStarted) {
      _refreshTokenStarted = true;
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
                final refresTokenResponse =
                    await _sessionRepository.refreshToken(sessionResult);
                log('refresh token called');
                switch (refresTokenResponse.result) {
                  case Result.succeed:
                    if (refresTokenResponse.successData != null) {
                      await _sessionRepository
                          .saveSessionInfo(refresTokenResponse.successData!);
                      _streamController.add(ResultHolder.success(
                          refresTokenResponse.successData!));
                      _refreshTokenStarted = false;
                      log('Calling refresh token use case again');
                      this();
                    }
                    break;
                  case Result.failed:
                    // TODO: Handle this case.
                    _streamController.add(
                      ResultHolder.fail(
                          const ErrorModel(code: 'code', message: 'message')),
                    );
                    break;
                }
              });
            }
            break;
          case Result.failed:
            // TODO: Handle this case.
            _streamController.add(
              ResultHolder.fail(
                  const ErrorModel(code: 'code', message: 'message')),
            );
            break;
        }
      });
    }

    return _streamController.stream;
  }
}
