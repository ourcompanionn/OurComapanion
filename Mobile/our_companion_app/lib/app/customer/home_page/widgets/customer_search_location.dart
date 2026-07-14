import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/app/shared/widgets/app_text_field.dart';
import 'package:our_companion_app/app/shared/widgets/animated_gradient_border.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

class CustomerSearchLocation extends ConsumerWidget {
  const CustomerSearchLocation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);

    return AnimatedGradientBorder(
      borderWidth: 2.0,
      borderRadius: BorderRadius.circular(25),
      backgroundColor: appColors.background,
      padding: EdgeInsets.zero,
      gradient: SweepGradient(
        colors: [appColors.border, appColors.animatedBorder, appColors.border],
        stops: const [0.0, 0.2, 0.5],
      ),
      child: AppTextField(
        controller: TextEditingController(),
        hintText: 'Search for services...',
        prefixIcon: Icons.search,
        readOnly: true,
        showBorder: false,
        onTap: () {
          context.push(AppRoutes.customerRequest);
        },
      ),
    );
  }
}
