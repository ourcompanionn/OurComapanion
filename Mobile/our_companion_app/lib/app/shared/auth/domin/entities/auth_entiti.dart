import 'package:our_companion_app/app/shared/auth/domin/entities/account_entiti.dart';


class AuthEntity {
  final bool isRegistrationRequired;
  final String accessToken;
  final String refreshToken;
  final AccountEntity? account;

  const AuthEntity({
    required this.isRegistrationRequired,
    required this.accessToken,
    required this.refreshToken,
     this.account,
  });
}