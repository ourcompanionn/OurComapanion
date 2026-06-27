import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repository/auth_repository.dart';
import 'auth_state.dart';

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  final AuthRepository _repository = AuthRepository();

  Timer? _timer;

  @override
  AuthState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });

    return const AuthState();
  }

  void setSignupMethod(SignupMethod method) {
    _timer?.cancel();

    state = state.copyWith(
      signupMethod: method,
      otpSent: false,
      timerSeconds: 30,
    );
  }

  Future<void> sendOtp(
    String value,
    void Function(String message) onSuccess,
  ) async {
    state = state.copyWith(isLoading: true);

    await _repository.sendOtp(
      value: value,
      isEmail: state.signupMethod == SignupMethod.email,
    );

    if (state.signupMethod == SignupMethod.phone) {
      state = state.copyWith(phone: value);
    } else {
      state = state.copyWith(email: value);
    }

    state = state.copyWith(isLoading: false, otpSent: true);

    startTimer();

    onSuccess("OTP Sent");
  }

  Future<void> verifyOtp(
    String otp,
    void Function(bool exists) onResult,
  ) async {
    state = state.copyWith(isLoading: true);

    final result = await _repository.verifyOtp(
      value: state.signupMethod == SignupMethod.phone
          ? state.phone
          : state.email,
      otp: otp,
    );

    state = state.copyWith(isLoading: false);

    onResult(result.userExists);
  }

  Future<void> googleLogin(void Function(bool exists) onResult) async {
    state = state.copyWith(isLoading: true);

    final result = await _repository.signInWithGoogle();

    state = state.copyWith(isLoading: false);

    onResult(result.userExists);
  }

  void editContact() {
    _timer?.cancel();

    state = state.copyWith(otpSent: false, timerSeconds: 30);
  }

  void startTimer() {
    _timer?.cancel();

    state = state.copyWith(timerSeconds: 30);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timerSeconds > 0) {
        state = state.copyWith(timerSeconds: state.timerSeconds - 1);
      } else {
        timer.cancel();
      }
    });
  }
}
