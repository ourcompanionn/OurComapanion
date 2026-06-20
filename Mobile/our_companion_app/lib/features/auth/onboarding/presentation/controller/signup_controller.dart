import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/features/auth/onboarding/presentation/pages/profile_setup_page.dart';
import 'package:our_companion_app/features/auth/onboarding/presentation/providers/signup_provider.dart';
import 'package:our_companion_app/shared/widgets/app_snackbar.dart';

class SignupController {
  final WidgetRef ref;
  final BuildContext context;
  final GlobalKey<FormState> formKey;

  SignupController({
    required this.ref,
    required this.context,
    required this.formKey,
  });

  void sendOtp({required String phone, required String email}) {
    if (formKey.currentState!.validate()) {
      final signupState = ref.read(signupProvider);

      final target = signupState.signupMethod == SignupMethod.phone
          ? phone.trim()
          : email.trim();

      ref.read(signupProvider.notifier).sendOtp(target, (message) {
         AppToast.show(
        context,
        message: message,
        backgroundColor: ref.read(appColorsProvider).primary,
        duration: Duration(seconds: 2),
      );
      });
    }
  }

  void verifyOtp(String otp) {
    if (formKey.currentState!.validate()) {
      ref.read(signupProvider.notifier).verifyOtp(otp.trim(), (message) {
         AppToast.show(
        context,
        message: message,
        backgroundColor: ref.read(appColorsProvider).primary,
        duration: Duration(seconds: 2),
      );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfileSetupPage()),
        );
      });
    }
  }

  void googleSignIn() {
    ref.read(signupProvider.notifier).signInWithGoogle((message) {
      AppToast.show(
        context,
        message: message,
        backgroundColor: ref.read(appColorsProvider).primary,
        duration: Duration(seconds: 2),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProfileSetupPage()),
      );
    });
  }
}
