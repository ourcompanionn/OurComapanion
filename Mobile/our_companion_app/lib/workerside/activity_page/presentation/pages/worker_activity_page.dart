import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class WorkerActivityPage extends ConsumerWidget {
  const WorkerActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    return Scaffold(
      backgroundColor: appColors.background,
      body: Center(
        child: Text(
          'Worker Activity',
          style: GoogleFonts.poppins(color: appColors.text, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
