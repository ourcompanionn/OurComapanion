import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';
import 'package:our_companion_app/app/shared/widgets/app_button.dart';
import 'package:our_companion_app/app/shared/request/presentation/controller/location_field_controller.dart';

class CustomerRequestCollapsedView extends ConsumerWidget {
  const CustomerRequestCollapsedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    final locationController = ref.watch(locationFieldControllerProvider);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: appColors.secondaryText.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Destination Field
            Container(
              decoration: BoxDecoration(
                color: appColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: appColors.border),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.square, size: 16, color: appColors.primary),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: locationController.destinationController,
                      onChanged: locationController.setDestination,
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          context.push(AppRoutes.customerServiceSelect);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Where to?',
                        hintStyle: GoogleFonts.poppins(
                          color: appColors.secondaryText,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                      style: GoogleFonts.poppins(color: appColors.text),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Continue Button
            AppButton(
              bgcolor: appColors.primary,
              height: 54,
              width: double.infinity,
              text: 'Continue Request',
              onPressed: () {
                context.push(AppRoutes.customerServiceSelect);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
