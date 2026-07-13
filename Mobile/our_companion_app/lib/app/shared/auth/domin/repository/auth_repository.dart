import 'package:our_companion_app/app/shared/auth/domin/entities/auth_entiti.dart';


abstract class AuthRepository {
  Future<void> requestOtp(String phoneNumber);

  Future<AuthEntity> verifyOtp({
    required String phoneNumber,
    required String otpCode,
    required String deviceIdentifier,
    required String platform,
    required String deviceName,
  });

  Future<AuthEntity> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String accountType,
    required String deviceIdentifier,
    required String platform,
    required String deviceName,
  });

  Future<AuthEntity> refreshToken(
    String refreshToken,
  );

  Future<void> logout(
    String refreshToken,
  );
}