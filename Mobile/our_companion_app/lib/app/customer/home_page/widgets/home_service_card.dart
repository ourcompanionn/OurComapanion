import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';
import 'package:our_companion_app/app/customer/service_page/data/models/service_item.dart';
import 'package:our_companion_app/app/shared/request/provider/request_form_provider.dart';

class HomeServiceCard extends ConsumerWidget {
  final AppColors appColors;
  final ServiceItem service;

  const HomeServiceCard({
    super.key,
    required this.appColors,
    required this.service,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref
            .read(requestFormProvider.notifier)
            .setSelectedService(service.title, icon: service.icon);
        context.push(AppRoutes.customerRequest);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: appColors.surface,
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(color: appColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: appColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(service.icon, color: appColors.primary, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              service.title.replaceAll('\n', ' '),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                color: appColors.text,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
