import 'dart:async';

import 'package:sulion_app/src/core/session/domain/use_case/refresh_token_use_case.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';

class AppViewModel {
  AppViewModel(this._refreshTokenUseCase);
  final RefreshTokenUseCase _refreshTokenUseCase;
  final StreamController<AppState> _controller = StreamController();
  Stream<AppState> get state => _controller.stream;

  bootstrap() {}
}

class AppState {
  AppState({required this.isSessionActive, this.error});
  factory AppState.sessionExpired() {
    return AppState(isSessionActive: false);
  }
  factory AppState.loginSuccessful() {
    return AppState(isSessionActive: true);
  }
  bool isSessionActive;
  ErrorModel? error;
}
