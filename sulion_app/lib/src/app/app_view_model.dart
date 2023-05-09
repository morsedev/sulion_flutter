import 'dart:async';

import 'package:sulion_app/src/app/domain/entity/refresh_token_request.dart';
import 'package:sulion_app/src/app/domain/use_case/refresh_token_use_case.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';

class AppViewModel {
  AppViewModel(this._refreshTokenUseCase);
  final RefreshTokenUseCase _refreshTokenUseCase;
  final StreamController<AppState> _controller = StreamController();
  Stream<AppState> get state => _controller.stream;

  bootstrap() {
    Timer.periodic(const Duration(seconds: 6), (timer) async {
      // TODO: obtener refreshtoken desde SharedPreferences
      var response =
          await _refreshTokenUseCase(RefreshTokenRequest(refreshToken: ''));

      switch (response.result) {
        case Result.succeed:
          // TODO: almacenar refreshtoken en SharedPreferences
          // TODO: Actualizar el timer con la información de la respuesta
          break;
        case Result.failed:
          // TODO: Actualizamos el AppSate para enviar al usuario al Login
          _controller.add(AppState.sessionExpired());
          timer.cancel();
          break;
      }
    });
  }
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
