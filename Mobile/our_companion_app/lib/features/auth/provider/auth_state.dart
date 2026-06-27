enum SignupMethod {
  phone,
  email,
  google,
}

class AuthState {
  final SignupMethod signupMethod;

  final String phone;
  final String email;

  final bool otpSent;
  final bool isLoading;

  final int timerSeconds;

  const AuthState({
    this.signupMethod = SignupMethod.phone,
    this.phone = '',
    this.email = '',
    this.otpSent = false,
    this.isLoading = false,
    this.timerSeconds = 30,
  });

  AuthState copyWith({
    SignupMethod? signupMethod,
    String? phone,
    String? email,
    bool? otpSent,
    bool? isLoading,
    int? timerSeconds,
  }) {
    return AuthState(
      signupMethod: signupMethod ?? this.signupMethod,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      otpSent: otpSent ?? this.otpSent,
      isLoading: isLoading ?? this.isLoading,
      timerSeconds: timerSeconds ?? this.timerSeconds,
    );
  }
}