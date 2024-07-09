
import 'package:boilerplate/models/auth/auth.dart';

class RegisterResult {
  final AuthResultStatus resultStatus;
  final String? token;
  final String? refreshToken;

  RegisterResult({
    required this.resultStatus,
    this.token,
    this.refreshToken,
  });
}