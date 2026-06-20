import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/features/auth/onboarding/presentation/providers/signup_provider.dart';

class SignupMethodTabs extends ConsumerWidget {
  final SignupMethod selectedMethod;
  final ValueChanged<SignupMethod> onMethodChanged;

  const SignupMethodTabs({
    super.key,
    required this.selectedMethod,
    required this.onMethodChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: _TabButton(
            label: 'Phone Number',
            isSelected: selectedMethod == SignupMethod.phone,
            onTap: () => onMethodChanged(SignupMethod.phone),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _TabButton(
            label: 'Email Address',
            isSelected: selectedMethod == SignupMethod.email,
            onTap: () => onMethodChanged(SignupMethod.email),
          ),
        ),
      ],
    );
  }
}

class _TabButton extends ConsumerWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? appColors.background : appColors.surface,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? appColors.accent : appColors.border,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: isSelected ? appColors.text : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }
}
