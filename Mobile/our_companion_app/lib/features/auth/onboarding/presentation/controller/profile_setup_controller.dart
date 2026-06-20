import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/features/auth/onboarding/domain/entities/user_role.dart';
import 'package:our_companion_app/features/auth/onboarding/presentation/pages/worker_category_page.dart';
import 'package:our_companion_app/features/auth/onboarding/presentation/providers/role_provider.dart';
import 'package:our_companion_app/features/auth/onboarding/presentation/providers/signup_provider.dart';
import 'package:our_companion_app/features/customer/home_page/presentation/customer_main_page.dart';
import 'package:our_companion_app/shared/widgets/app_snackbar.dart';

class ProfileSetupController {
  final WidgetRef ref;
  final BuildContext context;
  final GlobalKey<FormState> formKey;

  ProfileSetupController({
    required this.ref,
    required this.context,
    required this.formKey,
  });

  void onContinue({
    required String name,
    required String email,
    required String phone,
  }) {
    if (formKey.currentState!.validate()) {
      final signupState = ref.read(signupProvider);
      if (signupState.gender.isEmpty) {
        AppToast.show(
          context,
          message: "Please select your gender",
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        );
        return;
      }

      ref.read(signupProvider.notifier).setName(name.trim());

      if (signupState.signupMethod == SignupMethod.phone) {
        ref.read(signupProvider.notifier).setEmail(email.trim());
      } else {
        ref.read(signupProvider.notifier).setPhone(phone.trim());
      }

      final selectedRole = ref.read(roleProvider);
      if (selectedRole == UserRole.worker) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WorkerCategoryPage()),
        );
      } else {
        ref.read(signupProvider.notifier).completeSignup((message) {
          AppToast.show(
            context,
            message: message,
            backgroundColor: ref.read(appColorsProvider).primary,
            duration: Duration(seconds: 2),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const CustomerMainPage()),
            (route) => false,
          );
        });
      }
    }
  }
}
