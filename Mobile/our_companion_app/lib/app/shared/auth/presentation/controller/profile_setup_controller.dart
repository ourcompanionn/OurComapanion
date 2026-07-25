import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:our_companion_app/app/shared/auth/presentation/controller/signup_ui_state.dart';
import 'package:our_companion_app/app/shared/auth/presentation/provider/auth_provider.dart';
import 'package:our_companion_app/core/providers/core_provider.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';
import 'package:our_companion_app/app/shared/auth/domin/entities/user_role.dart';
import 'package:our_companion_app/app/shared/onboarding/presentation/providers/profile_provider.dart';
import 'package:our_companion_app/app/shared/onboarding/presentation/providers/role_provider.dart';
import 'package:our_companion_app/app/shared/widgets/app_snackbar.dart';

class ProfileSetupController {
  final WidgetRef ref;
  final BuildContext context;
  final GlobalKey<FormState> formKey;

  ProfileSetupController({
    required this.ref,
    required this.context,
    required this.formKey,
  });
  Future<void> onContinue({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    if (!formKey.currentState!.validate()) return;

    final profile = ref.read(profileProvider);
    final signupState = ref.read(signupUiProvider);

    if (profile.gender.isEmpty) {
      AppToast.show(
        context,
        message: "Please select your gender",
        backgroundColor: Colors.red,
      );
      return;
    }

    ref.read(profileProvider.notifier).setName("$firstName $lastName");
    if (signupState.signupMethod == SignupMethod.phone) {
      // Save secondary email if needed later
    } else {
      // Save secondary phone if needed later
    }

    final role = ref.read(roleProvider);

    final phoneNumber = await ref.read(secureStorageProvider).getPhoneNumber();

    print("Saved Phone Number: $phoneNumber");

    await ref
        .read(authControllerProvider.notifier)
        .register(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber ?? "",
          accountType: role.name,
          deviceIdentifier: "device-id",
          platform: "Mobile",
          deviceName: "Android",
        );
    final authState = ref.read(authControllerProvider);

    if (authState.error != null || authState.auth == null) {
      AppToast.show(
        context,
        message: authState.error ?? "Registration failed",
        backgroundColor: Colors.red,
      );
      return;
    }
    if (role == UserRole.worker) {
      context.go(AppRoutes.workerCategory);
    } else {
      context.go(AppRoutes.customerMain);
    }
  }
}
