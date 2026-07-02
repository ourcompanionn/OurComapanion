import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';
import 'package:our_companion_app/features/auth/domin/entities/user_role.dart';
import 'package:our_companion_app/features/auth/provider/login_provider.dart';
import 'package:our_companion_app/features/onboarding/presentation/providers/role_provider.dart';
import 'package:our_companion_app/shared/widgets/app_snackbar.dart';

class LoginController {
  final WidgetRef ref;
  final BuildContext context;
  final GlobalKey<FormState> formKey;

  LoginController({
    required this.ref, 
    required this.context,
    required this.formKey,
  });

  void sendOtp(String phone) {
    if (formKey.currentState!.validate()) {
      ref.read(loginProvider.notifier).sendOtp(phone.trim(), (message) {
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
      ref.read(loginProvider.notifier).verifyOtp(otp.trim(), (message) {
        AppToast.show(
          context,
          message: message,
          backgroundColor: ref.read(appColorsProvider).primary,
          duration: Duration(seconds: 2),
        );

        final role = ref.read(roleProvider);
        if (role == UserRole.customer) {
          context.go(AppRoutes.customerMain);
        } else if (role == UserRole.worker) {
          context.go(AppRoutes.workerMain);
        }
      });
    }
  }
}
