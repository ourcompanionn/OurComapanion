import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';

import 'package:our_companion_app/features/auth/provider/auth_provider.dart';
import 'package:our_companion_app/features/auth/provider/auth_state.dart';

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

  Future<void> sendOtp({
    required String phone,
    required String email,
  }) async {
    if (!formKey.currentState!.validate()) return;

    final auth = ref.read(authProvider);

    final value = auth.signupMethod == SignupMethod.phone
        ? phone.trim()
        : email.trim();

    await ref.read(authProvider.notifier).sendOtp(
      value,
      (message) {
        AppToast.show(
          context,
          message: message,
          backgroundColor: ref.read(appColorsProvider).primary,
        );
      },
    );
  }

  Future<void> verifyOtp(String otp) async {
    if (!formKey.currentState!.validate()) return;

    await ref.read(authProvider.notifier).verifyOtp(
      otp,
      (exists) {
        if (exists) {
          context.go(AppRoutes.customerMain);
        } else {
          context.go(AppRoutes.profileSetup);
        }
      },
    );
  }

  Future<void> googleLogin() async {
    await ref.read(authProvider.notifier).googleLogin(
      (exists) {
        if (exists) {
          context.go(AppRoutes.customerMain);
        } else {
          context.go(AppRoutes.profileSetup);
        }
      },
    );
  }
}