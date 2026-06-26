import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginState {
  final bool otpSent;
  final int timerSeconds;
  final bool isLoading;

  LoginState({
    required this.otpSent,
    required this.timerSeconds,
    required this.isLoading,
  });

  LoginState copyWith({bool? otpSent, int? timerSeconds, bool? isLoading}) {
    return LoginState(
      otpSent: otpSent ?? this.otpSent,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LoginNotifier extends Notifier<LoginState> {
  Timer? _timer;

  @override
  LoginState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return LoginState(otpSent: false, timerSeconds: 30, isLoading: false);
  }

  void startTimer() {
    _timer?.cancel();
    state = state.copyWith(timerSeconds: 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timerSeconds > 0) {
        state = state.copyWith(timerSeconds: state.timerSeconds - 1);
      } else {
        _timer?.cancel();
      }
    });
  }

  void sendOtp(String phone, void Function(String message) onSuccess) {
    state = state.copyWith(isLoading: true);
    Future.delayed(const Duration(milliseconds: 500), () {
      state = state.copyWith(otpSent: true, isLoading: false);
      startTimer();
      onSuccess('OTP sent successfully to your phone number!');
    });
  }

  void editPhone() {
    _timer?.cancel();
    state = state.copyWith(otpSent: false, timerSeconds: 30);
  }

  void verifyOtp(String otp, void Function(String message) onSuccess) {
    state = state.copyWith(isLoading: true);
    Future.delayed(const Duration(milliseconds: 500), () {
      state = state.copyWith(isLoading: false);
      onSuccess('Sign in successful!');
    });
  }
}

final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);
