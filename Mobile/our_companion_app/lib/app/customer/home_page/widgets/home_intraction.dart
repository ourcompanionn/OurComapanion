import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/app/customer/home_page/widgets/recent_locationn_card.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class HomeIntraction extends ConsumerWidget {
  final AppColors appColors;
  const HomeIntraction({super.key, required this.appColors});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    return Container(
      width: double.infinity,
      height: 230,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [appColors.primary, Color.fromARGB(255, 0, 85, 78)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Find Your\nBest Companion',
              style: GoogleFonts.aBeeZee(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Where would you like to go?',
              style: GoogleFonts.poppins(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14,
              ),
            ),
            SizedBox(height: 15),
            RecentLocationCard(appColors: appColors),
          ],
        ),
      ),
    );
  }
}
