import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class BuildProfileOption extends StatelessWidget {

 final IconData icon;
 final String title;
 final AppColors colores;
 final VoidCallback? onTap;
  const BuildProfileOption({super.key,
  required this.icon,
  required this.title,
  required this.colores,
   this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colores.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: colores.primary),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: colores.text
        ),
      ),
      trailing: Icon(Icons.chevron_right, color:colores.secondaryText),
    );
  }
}