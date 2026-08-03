import '../repository/auth_repository.dart';

class RequestOtpUseCase {
  final AuthRepository repository;

  const RequestOtpUseCase(this.repository);

  Future<void> call(String phoneNumber) {
    return repository.requestOtp(phoneNumber);
  }
}