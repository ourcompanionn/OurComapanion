import 'package:our_companion_app/app/shared/auth/domin/entities/auth_entiti.dart';
import '../repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  const RegisterUseCase(this.repository);

  Future<AuthEntity> call({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String accountType,
    required String deviceIdentifier,
    required String platform,
    required String deviceName,
  }) {
    return repository.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      accountType: accountType,
      deviceIdentifier: deviceIdentifier,
      platform: platform,
      deviceName: deviceName,
    );
  }
}