enum SignupMethod {
  phone,
  email,
}

class SignupUiState {
  final bool otpSent;
  final bool isLoading;
  final SignupMethod signupMethod;

  final int timerSeconds;

  const SignupUiState({
    this.otpSent = false,
    this.isLoading = false,
    this.signupMethod = SignupMethod.phone,
    this.timerSeconds = 60,
  });

  SignupUiState copyWith({
    bool? otpSent,
    bool? isLoading,
    SignupMethod? signupMethod,
    int? timerSeconds,
  }) {
    return SignupUiState(
      otpSent: otpSent ?? this.otpSent,
      isLoading: isLoading ?? this.isLoading,
      signupMethod: signupMethod ?? this.signupMethod,
      timerSeconds: timerSeconds ?? this.timerSeconds,
    );
  }
}