import 'package:sulion_app/src/core/session/domain/entity/login_entity.dart';

class LoginRequestModel {
  const LoginRequestModel({
    required this.username,
    required this.password,
  });

  factory LoginRequestModel.fromEntity(LoginEntity entity) {
    return LoginRequestModel(
        username: entity.username, password: entity.password);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'username': username, 'password': password};

  final String password;
  final String username;
}
