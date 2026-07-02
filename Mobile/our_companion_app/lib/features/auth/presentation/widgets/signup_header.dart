import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class SignupHeader extends ConsumerWidget {
  final bool otpSent;

  const SignupHeader({super.key, required this.otpSent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'Create Account',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: appColors.secondary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          otpSent
              ? 'Enter the 6-digit OTP code sent to verify'
              : 'Sign up to find expert helpers or services',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
