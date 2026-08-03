import 'package:our_companion_app/app/shared/auth/domin/entities/auth_entiti.dart';
import '../repository/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  const VerifyOtpUseCase(this.repository);

  Future<AuthEntity> call({
    required String phoneNumber,
    required String otpCode,
    required String deviceIdentifier,
    required String platform,
    required String deviceName,
  }) {
    return repository.verifyOtp(
      phoneNumber: phoneNumber,
      otpCode: otpCode,
      deviceIdentifier: deviceIdentifier,
      platform: platform,
      deviceName: deviceName,
    );
  }
}