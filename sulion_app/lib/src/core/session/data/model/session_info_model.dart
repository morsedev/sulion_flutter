import 'dart:convert';

class SessionInfoModel {
  const SessionInfoModel({
    required this.token,
    required this.refreshToken,
    required this.expiration,
  });
  final String token;
  final String refreshToken;
  final int expiration;

  factory SessionInfoModel.fromJson([Map<String, dynamic>? map, String? json]) {
    if (json != null) {
      var map = jsonDecode(json);
      return SessionInfoModel(
        token: map[_SessionInfoModelKeys.token] ?? '',
        refreshToken: map[_SessionInfoModelKeys.refreshToken] ?? '',
        expiration: map[_SessionInfoModelKeys.expiration] ?? '',
      );
    }

    return SessionInfoModel(
      token: map?[_SessionInfoModelKeys.token] ?? '',
      refreshToken: map?[_SessionInfoModelKeys.refreshToken] ?? '',
      expiration: map?[_SessionInfoModelKeys.expiration] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _SessionInfoModelKeys.token: token,
      _SessionInfoModelKeys.refreshToken: refreshToken,
      _SessionInfoModelKeys.expiration: expiration,
    };
  }
}

class _SessionInfoModelKeys {
  static const token = 'token';
  static const refreshToken = 'refreshToken';
  static const expiration = 'expiration';
}
