import '../repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  const LogoutUseCase(this.repository);

  Future<void> call(String refreshToken) {
    return repository.logout(refreshToken);
  }
}