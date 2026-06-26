import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/constents/app_sizes.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';
import 'package:our_companion_app/features/auth/domin/entities/user_role.dart';
import 'package:our_companion_app/features/auth/presentation/widgets/role_card.dart';
import 'package:our_companion_app/features/onboarding/presentation/providers/role_provider.dart';
import 'package:our_companion_app/shared/widgets/app_button.dart';

class RoleSelectPage extends ConsumerWidget {
  const RoleSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    final selectedRole = ref.watch(roleProvider);

    return Scaffold(
      backgroundColor: appColors.background,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How would you like to use this App?',
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSizes.sizedH5,
            Text(
              'Choose your role to get started',
              style: GoogleFonts.poppins(),
            ),
            AppSizes.sizedH20,
            RoleCard(
              title: 'I am Costumer',
              subtitle:
                  'Continue as a customer and get your tasks done with ease.',
              isSelected: selectedRole == UserRole.customer,
              onTap: () {
                ref
                    .read(roleProvider.notifier)
                    .setRole(
                      selectedRole == UserRole.customer
                          ? UserRole.none
                          : UserRole.customer,
                    );
              },
            ),
            AppSizes.sizedH20,
            RoleCard(
              title: 'I am Worker',
              subtitle:
                  'Continue as a worker and find jobs that fit your expertise.',
              isSelected: selectedRole == UserRole.worker,
              onTap: () {
                ref
                    .read(roleProvider.notifier)
                    .setRole(
                      selectedRole == UserRole.worker
                          ? UserRole.none
                          : UserRole.worker,
                    );
              },
            ),
            const SizedBox(height: 50),
            AppButton(
              text: 'Continue',
              bgcolor: selectedRole != UserRole.none
                  ? appColors.primary
                  : appColors.primary.withValues(alpha: 0.5),
              height: 55,
              width: double.infinity,
              onPressed: selectedRole != UserRole.none
                  ? () {
                      context.push(AppRoutes.signup);
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
