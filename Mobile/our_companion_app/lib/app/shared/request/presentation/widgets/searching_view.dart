import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class SearchingView extends StatelessWidget {
  final AppColors appColors;

  const SearchingView({super.key, required this.appColors});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: appColors.primary),
          const SizedBox(height: 24),
          Text(
            'Finding nearby companions...',
            style: GoogleFonts.poppins(
              color: appColors.text,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
