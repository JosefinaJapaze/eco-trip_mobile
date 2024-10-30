enum RegisterStatus { success, userAlreadyExists, badRequest, error }

class RegisterResult {
  final RegisterStatus resultStatus;
  final String? token;
  final String? refreshToken;

  RegisterResult({
    required this.resultStatus,
    this.token,
    this.refreshToken,
  });
}
