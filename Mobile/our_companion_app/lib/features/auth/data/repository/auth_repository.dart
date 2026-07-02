import 'package:our_companion_app/features/auth/data/model/auth_result.dart';

class AuthRepository {
  Future<void> sendOtp({required String value, required bool isEmail}) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<AuthResult> verifyOtp({
    required String value,
    required String otp,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    if (otp != "123456") {
      throw Exception("Invalid OTP");
    }

    final exists = value == "9999999999" || value == "existing@gmail.com";

    return AuthResult(token: "dummy_token", userExists: exists);
  }

  Future<AuthResult> signInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 2));

    return AuthResult(token: "google_token", userExists: false);
  }
}
