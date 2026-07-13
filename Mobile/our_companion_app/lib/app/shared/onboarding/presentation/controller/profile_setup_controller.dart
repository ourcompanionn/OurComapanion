import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:our_companion_app/app/shared/auth/presentation/controller/signup_ui_state.dart';
import 'package:our_companion_app/app/shared/auth/presentation/provider/auth_provider.dart';
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
void onContinue({
  required String name,
  required String email,
  required String phone,
}) {
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

  ref.read(profileProvider.notifier).setName(name);

  if (signupState.signupMethod == SignupMethod.phone) {
    // Save secondary email if needed later
  } else {
    // Save secondary phone if needed later
  }

  final role = ref.read(roleProvider);

  if (role == UserRole.worker) {
    context.push(AppRoutes.workerCategory);
  } else {
    context.go(AppRoutes.customerMain);
  }
}}