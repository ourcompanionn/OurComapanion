import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class WorkerHomePage extends ConsumerWidget {
  const WorkerHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    return Scaffold(
      backgroundColor: appColors.background,
      body: Center(
        child: Text(
          'Worker Home',
          style: GoogleFonts.poppins(color: appColors.text, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
