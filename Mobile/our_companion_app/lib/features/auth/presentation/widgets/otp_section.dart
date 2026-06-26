import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/shared/widgets/app_text_field.dart';

class OtpSection extends ConsumerWidget {
  final dynamic signupState;
  final TextEditingController otpController;
  final VoidCallback onResend;

  const OtpSection({
    super.key,
    required this.signupState,
    required this.otpController,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    return Column(
      children: [
        Text(
          'OTP Code',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        AppTextField(
          controller: otpController,
          hintText: '• • • • • •',
          keyboardType: TextInputType.number,
          letterSpacing: 8,
          textAlign: TextAlign.center,
          maxLength: 6,
          prefixIcon: Icons.lock_open_outlined,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the OTP';
            }
            if (value.length < 6) {
              return 'OTP must be 6 digits';
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: signupState.timerSeconds == 0 ? onResend : null,
            child: Text(
              signupState.timerSeconds > 0
                  ? 'Resend OTP in ${signupState.timerSeconds}s'
                  : 'Resend OTP',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: signupState.timerSeconds == 0
                    ? appColors.primary
                    : Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
