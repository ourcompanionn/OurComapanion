import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/constents/app_sizes.dart';

class RoleCard extends ConsumerWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: AppSizes.padding15.padding,
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: appColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: isSelected ? appColors.primary : appColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: isSelected ? appColors.primary : Colors.black,
              ),
            ),
            AppSizes.sizedW20,
            Text(
              subtitle,
              style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
