import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class ServiceCard extends ConsumerWidget {
  final String title;
  final IconData icon;
  final String description;
  final String? imagePath;

  const ServiceCard({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);

    return Stack(
      children: [
        Container(
          height: 260,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: appColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: appColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: appColors.primary.withValues(alpha: 0.1),
                  child: Icon(icon, color: appColors.primary),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: appColors.text,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: appColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Explore Now >',
                    style: TextStyle(color: appColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Top-right image
        if (imagePath != null)
          Positioned(
            top: 10,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath!,
                height: 140,
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),
      ],
    );
  }
}
