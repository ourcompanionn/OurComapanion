import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class RequestTypeChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final AppColors appColors;
  final bool isSelected;
  final VoidCallback onTap;

  const RequestTypeChip({
    super.key,
    required this.icon,
    required this.label,
    required this.appColors,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? appColors.primary : appColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? appColors.primary : appColors.border,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : appColors.text,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.white : appColors.text,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
