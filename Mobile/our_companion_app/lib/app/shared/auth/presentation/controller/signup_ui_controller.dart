import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'signup_ui_state.dart';

class SignupUiController extends StateNotifier<SignupUiState> {
  SignupUiController() : super(const SignupUiState());

  Timer? _timer;

  void setSignupMethod(SignupMethod method) {
    state = state.copyWith(signupMethod: method);
  }

  void setOtpSent(bool value) {
    state = state.copyWith(otpSent: value);

    if (value) {
      startTimer();
    }
  }

  void editContact() {
    _timer?.cancel();

    state = state.copyWith(
      otpSent: false,
      timerSeconds: 60,
    );
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void startTimer() {
    _timer?.cancel();

    state = state.copyWith(timerSeconds: 60);

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state.timerSeconds == 0) {
          timer.cancel();
        } else {
          state = state.copyWith(
            timerSeconds: state.timerSeconds - 1,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}