import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

import 'package:go_router/go_router.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';

class SignupFooter extends ConsumerWidget {
  const SignupFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: GoogleFonts.poppins(color: Colors.grey[600]),
        ),
        GestureDetector(
          onTap: () => context.push(AppRoutes.login),
          child: Text(
            'Sign In',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: appColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
