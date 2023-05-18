import 'dart:async';

import 'package:sulion_app/src/core/session/domain/use_case/refresh_token_use_case.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';

class AppViewModel {
  AppViewModel(this._refreshTokenUseCase);
  final RefreshTokenUseCase _refreshTokenUseCase;
  final StreamController<AppState> _controller = StreamController();
  Stream<AppState> get state => _controller.stream;

  bootstrap() {
    _refreshTokenUseCase().listen((event) {
      switch (event.result) {
        case Result.succeed:
          // TODO: Handle this case.
          break;
        case Result.failed:
          // TODO: Handle this case.
          _controller.add(AppState.sessionExpired());
          break;
      }
    });
  }
}

class AppState {
  AppState({required this.result, this.error});
  factory AppState.sessionExpired() {
    return AppState(result: AppStateSessionResult.sessionExpired);
  }
  factory AppState.noSessionInDevice() {
    return AppState(result: AppStateSessionResult.noSessionInDevice);
  }
  AppStateSessionResult result;
  ErrorModel? error;
}

enum AppStateSessionResult {
  sessionExpired,
  noSessionInDevice;
}
