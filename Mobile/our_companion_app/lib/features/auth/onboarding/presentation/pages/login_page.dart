import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/features/auth/onboarding/presentation/controller/login_controller.dart';
import 'package:our_companion_app/features/auth/onboarding/presentation/pages/signup_page.dart';
import 'package:our_companion_app/features/auth/onboarding/presentation/providers/login_provider.dart';
import 'package:our_companion_app/shared/widgets/app_button.dart';
import 'package:our_companion_app/shared/widgets/app_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = ref.watch(appColorsProvider);
    final loginState = ref.watch(loginProvider);
    final controller = LoginController(
      ref: ref,
      context: context,
      formKey: _formKey,
    );

    return Scaffold(
      backgroundColor: appColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Text(
                  'Welcome Back!',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: appColors.secondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  loginState.otpSent
                      ? 'Enter the 6-digit OTP code sent to your phone'
                      : 'Sign in with your phone number to continue',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 48),

                Text(
                  'Phone Number',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _phoneController,
                        hintText: 'Enter phone number',
                        keyboardType: TextInputType.phone,
                        readOnly: loginState.otpSent,
                        prefixIcon: Icons.phone_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(r'^[0-9]{10,12}$').hasMatch(value)) {
                            return 'Enter a valid 10-12 digit number';
                          }
                          return null;
                        },
                      ),
                    ),
                    if (loginState.otpSent) ...[
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          ref.read(loginProvider.notifier).editPhone();
                          _otpController.clear();
                        },
                        child: Text(
                          'Edit',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: appColors.accent,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 24),

                if (loginState.otpSent) ...[
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
                    controller: _otpController,
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
                      onPressed: loginState.timerSeconds == 0
                          ? () => ref
                                .read(loginProvider.notifier)
                                .sendOtp(_phoneController.text, (msg) {})
                          : null,
                      child: Text(
                        loginState.timerSeconds > 0
                            ? 'Resend OTP in ${loginState.timerSeconds}s'
                            : 'Resend OTP',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: loginState.timerSeconds == 0
                              ? appColors.primary
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                const SizedBox(height: 20),

                if (loginState.isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  AppButton(
                    text: loginState.otpSent ? 'Verify & Sign In' : 'Send OTP',
                    bgcolor: appColors.secondary,
                    height: 56,
                    width: double.infinity,
                    onPressed: loginState.otpSent
                        ? () => controller.verifyOtp(_otpController.text)
                        : () => controller.sendOtp(_phoneController.text),
                  ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.poppins(color: Colors.grey[600]),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: appColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
