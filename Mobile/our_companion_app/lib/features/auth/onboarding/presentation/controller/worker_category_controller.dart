import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/features/auth/onboarding/presentation/providers/signup_provider.dart';
import 'package:our_companion_app/features/worker/home_page/presentation/pages/worker_main_page.dart';
import 'package:our_companion_app/shared/widgets/app_snackbar.dart';

class WorkerCategoryController {
  final WidgetRef ref;
  final BuildContext context;

  WorkerCategoryController({required this.ref, required this.context});

  void onComplete() {
    final signupState = ref.read(signupProvider);
    if (signupState.selectedCategories.isEmpty) {
      AppToast.show(
        context,
        message: 'Please select at least one service category',
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
      return;
    }

    ref.read(signupProvider.notifier).completeSignup((message) {
      AppToast.show(
        context,
        message: message,
        backgroundColor: ref.read(appColorsProvider).accent,
        duration: Duration(seconds: 2),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WorkerMainPage()),
        (route) => false,
      );
    });
  }
}
