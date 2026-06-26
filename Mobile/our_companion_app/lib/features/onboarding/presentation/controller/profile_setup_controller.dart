import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';
import 'package:our_companion_app/features/auth/domin/entities/user_role.dart';
import 'package:our_companion_app/features/auth/provider/signup_provider.dart';
import 'package:our_companion_app/features/onboarding/presentation/providers/role_provider.dart';
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
        context.push(AppRoutes.workerCategory);
      } else {
        ref.read(signupProvider.notifier).completeSignup((message) {
          AppToast.show(
            context,
            message: message,
            backgroundColor: ref.read(appColorsProvider).primary,
            duration: Duration(seconds: 2),
          );
          context.go(AppRoutes.customerMain);
        });
      }
    }
  }
}
