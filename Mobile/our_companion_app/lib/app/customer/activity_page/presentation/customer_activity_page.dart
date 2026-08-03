import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class CustomerActivityPage extends ConsumerWidget {
  const CustomerActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    return Scaffold(
      backgroundColor: appColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Activities',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: appColors.secondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Track your companion service bookings and status',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: appColors.secondaryText,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 72,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No activities yet',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: appColors.text,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your booked companion visits will appear here.',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: appColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
