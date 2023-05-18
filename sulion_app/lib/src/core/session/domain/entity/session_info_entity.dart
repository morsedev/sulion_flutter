import 'package:sulion_app/src/shared/infra/local_datasource.dart';

class SessionInfoEntity extends Storable {
  SessionInfoEntity({this.token, this.refreshToken, this.expiration});
  String? token;
  String? refreshToken;
  int? expiration;

  @override
  Map<String, dynamic> toStorage() {
    return {
      _SessionInfoEntityConstant.tokenKey: token,
      _SessionInfoEntityConstant.refresTokenKey: refreshToken,
      _SessionInfoEntityConstant.expirationKey: expiration,
    };
  }

  @override
  Storable fromStorage(Map<String, dynamic> map) {
    return SessionInfoEntity(
      token: map[_SessionInfoEntityConstant.tokenKey],
      refreshToken: map[_SessionInfoEntityConstant.refresTokenKey],
      expiration: map[_SessionInfoEntityConstant.expirationKey],
    );
  }
}

class _SessionInfoEntityConstant {
  static const tokenKey = 'token';
  static const refresTokenKey = 'refresToken';
  static const expirationKey = 'expiration';
}
