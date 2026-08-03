import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';
import 'package:our_companion_app/app/shared/onboarding/presentation/providers/profile_provider.dart';
import 'package:our_companion_app/app/shared/widgets/app_snackbar.dart';

class WorkerCategoryController {
  final WidgetRef ref;
  final BuildContext context;
  

  WorkerCategoryController({required this.ref, required this.context});

  void onComplete() {
    final profileState = ref.read(profileProvider);
    if (profileState.selectedCategories.isEmpty) {
      AppToast.show(
        context,
        message: 'Please select at least one service category',
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
      return;
    }

    ref.read(profileProvider.notifier).completeSignup((message) {
      AppToast.show(
        context,
        message: message,
        backgroundColor: ref.read(appColorsProvider).accent,
        duration: Duration(seconds: 2),
      );
      context.go(AppRoutes.workerMain);
    });
  }
}
