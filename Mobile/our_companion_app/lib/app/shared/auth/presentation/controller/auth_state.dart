import 'package:our_companion_app/app/shared/auth/domin/entities/auth_entiti.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final AuthEntity? auth;

  const AuthState({
    this.isLoading = false,
    this.error,
    this.auth,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    AuthEntity? auth,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      auth: auth ?? this.auth,
    );
  }
}