import 'package:our_companion_app/app/shared/auth/domin/entities/auth_entiti.dart';
import '../repository/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository repository;

  const RefreshTokenUseCase(this.repository);

  Future<AuthEntity> call(String refreshToken) {
    return repository.refreshToken(refreshToken);
  }
}