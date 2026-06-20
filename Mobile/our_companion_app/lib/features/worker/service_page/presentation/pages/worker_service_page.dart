import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class WorkerServicePage extends ConsumerWidget {
  const WorkerServicePage({super.key});

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
                'Worker Services',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: appColors.secondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage your services and availability',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: appColors.secondaryText,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Center(
                  child: Text(
                    'No services configured yet.',
                    style: GoogleFonts.poppins(
                      color: appColors.secondaryText,
                      fontSize: 16,
                    ),
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
