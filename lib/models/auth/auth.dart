
enum AuthResultStatus {
  successful,
  wrongCredentials,
  userNotFound,
  badRequest,
}

class LoginResult {
  final AuthResultStatus resultStatus;
  final String? token;
  final String? refreshToken;

  LoginResult({required this.resultStatus, this.token, this.refreshToken});
}
