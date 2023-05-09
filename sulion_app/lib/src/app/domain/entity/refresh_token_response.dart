class RefreshTokenResponse {
  RefreshTokenResponse({this.newToken, this.expiresAt});
  String? newToken;
  int? expiresAt;
}
