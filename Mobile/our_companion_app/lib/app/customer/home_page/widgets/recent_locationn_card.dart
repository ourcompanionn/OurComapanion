import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';
import 'package:our_companion_app/app/shared/request/provider/request_form_provider.dart';

class RecentLocationCard extends ConsumerWidget {
  final AppColors appColors;

  const RecentLocationCard({super.key, required this.appColors});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentLocation = ref.watch(recentLocationProvider);

    if (recentLocation == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: appColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: appColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
           
            InkWell(
              onTap: () {
                ref.read(requestFormProvider.notifier).setPickupLocation(recentLocation['pickup'] ?? '');
                ref.read(requestFormProvider.notifier).setDestination(recentLocation['destination'] ?? '');
                context.push(AppRoutes.customerRequest);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.history, color: appColors.secondaryText, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recentLocation['destination'] ?? '',
                            style: GoogleFonts.poppins(
                              color: appColors.text,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            recentLocation['pickup'] ?? '',
                            style: GoogleFonts.poppins(
                              color: appColors.secondaryText,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: appColors.secondaryText, size: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
