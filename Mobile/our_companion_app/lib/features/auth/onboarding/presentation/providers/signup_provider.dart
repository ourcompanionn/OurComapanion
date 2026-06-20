import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SignupMethod { phone, email, google }

class SignupState {
  final SignupMethod signupMethod;
  final String emailOrPhone;
  final String email;
  final String phone;
  final String name;
  final String gender;
  final List<String> selectedCategories;
  final bool showCompanion;
  final bool showSkilled;
  final bool isLoading;
  final bool otpSent;
  final int timerSeconds;

  SignupState({
    required this.signupMethod,
    required this.emailOrPhone,
    required this.email,
    required this.phone,
    required this.name,
    required this.gender,
    required this.selectedCategories,
    required this.showCompanion,
    required this.showSkilled,
    required this.isLoading,
    required this.otpSent,
    required this.timerSeconds,
  });

  SignupState copyWith({
    SignupMethod? signupMethod,
    String? emailOrPhone,
    String? email,
    String? phone,
    String? name,
    String? gender,
    List<String>? selectedCategories,
    bool? showCompanion,
    bool? showSkilled,
    bool? isLoading,
    bool? otpSent,
    int? timerSeconds,
  }) {
    return SignupState(
      signupMethod: signupMethod ?? this.signupMethod,
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      showCompanion: showCompanion ?? this.showCompanion,
      showSkilled: showSkilled ?? this.showSkilled,
      isLoading: isLoading ?? this.isLoading,
      otpSent: otpSent ?? this.otpSent,
      timerSeconds: timerSeconds ?? this.timerSeconds,
    );
  }
}

class SignupNotifier extends Notifier<SignupState> {
  Timer? _timer;

  @override
  SignupState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return SignupState(
      signupMethod: SignupMethod.phone,
      emailOrPhone: '',
      email: '',
      phone: '',
      name: '',
      gender: '',
      selectedCategories: [],
      showCompanion: true,
      showSkilled: false,
      isLoading: false,
      otpSent: false,
      timerSeconds: 30,
    );
  }

  void setSignupMethod(SignupMethod method) {
    _timer?.cancel();
    state = state.copyWith(
      signupMethod: method,
      otpSent: false,
      timerSeconds: 30,
      emailOrPhone: '',
    );
  }

  void setEmailOrPhone(String value) {
    state = state.copyWith(emailOrPhone: value);
  }

  void setEmail(String value) {
    state = state.copyWith(email: value);
  }

  void setPhone(String value) {
    state = state.copyWith(phone: value);
  }

  void setName(String value) {
    state = state.copyWith(name: value);
  }

  void setGender(String value) {
    state = state.copyWith(gender: value);
  }

  void toggleCompanion() {
    state = state.copyWith(showCompanion: !state.showCompanion);
  }

  void toggleSkilled() {
    state = state.copyWith(showSkilled: !state.showSkilled);
  }

  void toggleCategory(String category) {
    final list = List<String>.from(state.selectedCategories);
    if (list.contains(category)) {
      list.remove(category);
    } else {
      list.add(category);
    }
    state = state.copyWith(selectedCategories: list);
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

  void sendOtp(String target, void Function(String message) onSuccess) {
    state = state.copyWith(isLoading: true);
    Future.delayed(const Duration(milliseconds: 500), () {
      state = state.copyWith(
        otpSent: true,
        isLoading: false,
        emailOrPhone: target,
      );
      if (state.signupMethod == SignupMethod.phone) {
        state = state.copyWith(phone: target);
      } else {
        state = state.copyWith(email: target);
      }
      startTimer();
      onSuccess('OTP sent successfully to $target!');
    });
  }

  void editContact() {
    _timer?.cancel();
    state = state.copyWith(otpSent: false, timerSeconds: 30);
  }

  void verifyOtp(String otp, void Function(String message) onSuccess) {
    state = state.copyWith(isLoading: true);
    Future.delayed(const Duration(milliseconds: 500), () {
      state = state.copyWith(isLoading: false);
      onSuccess('OTP verified successfully!');
    });
  }

  void signInWithGoogle(void Function(String message) onSuccess) {
    state = state.copyWith(isLoading: true);
    Future.delayed(const Duration(milliseconds: 800), () {
      state = state.copyWith(
        isLoading: false,
        signupMethod: SignupMethod.google,
        email: 'user.google@gmail.com',
      );
      onSuccess('Signed in with Google successfully!');
    });
  }

  void completeSignup(void Function(String message) onSuccess) {
    state = state.copyWith(isLoading: true);
    Future.delayed(const Duration(milliseconds: 800), () {
      state = state.copyWith(isLoading: false);
      onSuccess('Signup successfully completed!');
    });
  }
}

final signupProvider = NotifierProvider<SignupNotifier, SignupState>(
  SignupNotifier.new,
);
