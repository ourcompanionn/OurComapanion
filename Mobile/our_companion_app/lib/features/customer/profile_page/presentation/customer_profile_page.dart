import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class CustomerProfilePage extends ConsumerWidget {
  const CustomerProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    return Scaffold(
      backgroundColor: appColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Profile',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: appColors.secondary,
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 54,
                      backgroundColor: appColors.primary.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.person,
                        size: 54,
                        color: appColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome Customer',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: appColors.text,
                      ),
                    ),
                    Text(
                      'customer@example.com',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: appColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              _buildProfileOption(
                Icons.person_outline,
                'Edit Profile',
                appColors,
              ),
              _buildProfileOption(
                Icons.notifications_none_outlined,
                'Notifications',
                appColors,
              ),
              _buildProfileOption(
                Icons.shield_outlined,
                'Privacy & Safety',
                appColors,
              ),
              _buildProfileOption(
                Icons.help_outline_outlined,
                'Support & FAQ',
                appColors,
              ),
              const Divider(height: 32),
              _buildProfileOption(
                Icons.logout,
                'Sign Out',
                appColors,
                textColor: Colors.redAccent,
                iconColor: Colors.redAccent,
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    IconData icon,
    String title,
    AppColors appColors, {
    Color? textColor,
    Color? iconColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (iconColor ?? appColors.primary).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor ?? appColors.primary),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: textColor ?? appColors.text,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: appColors.secondaryText),
    );
  }
}
