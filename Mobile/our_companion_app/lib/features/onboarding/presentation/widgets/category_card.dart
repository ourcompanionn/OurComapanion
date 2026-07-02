import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class CategoryCard extends ConsumerWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isExpanded;
  final VoidCallback onTap;
  final Widget child;

  const CategoryCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isExpanded,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpanded ? appColors.primary : Colors.grey[200]!,
          width: isExpanded ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            leading: CircleAvatar(
              backgroundColor: isExpanded
                  ? appColors.surface.withValues(alpha: 0.1)
                  : Colors.grey[100],
              child: Icon(
                icon,
                color: isExpanded ? appColors.accent : Colors.grey[600],
              ),
            ),
            title: Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isExpanded ? appColors.secondary : Colors.black87,
              ),
            ),
            subtitle: Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: appColors.secondaryText,
              ),
            ),
            trailing: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: isExpanded ? appColors.primary : Colors.grey,
            ),
          ),
          if (isExpanded) ...[
            const Divider(height: 1, thickness: 1),
            Padding(padding: const EdgeInsets.all(20), child: child),
          ],
        ],
      ),
    );
  }
}
