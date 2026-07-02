import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_companion_app/core/providers/theme_provider.dart';

class AppColors {
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color text;
  final Color secondaryText;
  final Color border;

  const AppColors({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.surface,
    required this.text,
    required this.secondaryText,
    required this.border,
  });
}

const lightColors = AppColors(
  primary: Color(0xFF14B8A6),
  secondary: Color.fromARGB(255, 0, 49, 44),
  accent: Colors.teal,
  background: Color(0xFFF8FAFC),
  surface: Color(0xFFFFFFFF),
  text: Color(0xFF0F172A),
  secondaryText: Color(0xFF64748B),
  border: Color(0xFFE2E8F0),
);

const darkColors = AppColors(
  primary: Color(0xFF14B8A6),
  secondary: Color(0xFF80CBC4),
  accent: Colors.tealAccent,
  background: Color(0xFF121212),
  surface: Color(0xFF1E1E1E),
  text: Color(0xFFF8FAFC),
  secondaryText: Color(0xFF94A3B8),
  border: Color(0xFF333333),
);

final appColorsProvider = Provider<AppColors>((ref) {
  final themeMode = ref.watch(themeProvider);
  return themeMode == ThemeMode.dark ? darkColors : lightColors;
});
