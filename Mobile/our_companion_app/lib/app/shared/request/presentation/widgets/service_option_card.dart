import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/app/customer/service_page/data/models/service_item.dart';

class ServiceOptionCard extends StatelessWidget {
  final ServiceItem service;
  final bool isSelected;
  final AppColors appColors;
  final VoidCallback onTap;

  const ServiceOptionCard({
    super.key,
    required this.service,
    required this.isSelected,
    required this.appColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // color: isSelected
          //     ? appColors.primary.withValues(alpha: 0.08)
          //     : appColors.surface,
          color: appColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? appColors.primary : appColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? appColors.primary.withValues(alpha: 0.15)
                    : appColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                service.icon,
                color: isSelected ? appColors.primary : appColors.text,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.title.replaceAll('\n', ' '),
                    style: GoogleFonts.poppins(
                      color: appColors.text,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service.description,
                    style: GoogleFonts.poppins(
                      color: appColors.secondaryText,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: appColors.primary)
            else
              Icon(Icons.circle_outlined, color: appColors.border),
          ],
        ),
      ),
    );
  }
}
