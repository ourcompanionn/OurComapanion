import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/features/auth/presentation/controller/signup_controller.dart';
import 'package:our_companion_app/features/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:our_companion_app/features/auth/presentation/widgets/signup_method_tabs.dart';
import 'package:our_companion_app/features/auth/presentation/widgets/signup_header.dart';
import 'package:our_companion_app/features/auth/presentation/widgets/otp_section.dart';
import 'package:our_companion_app/features/auth/presentation/widgets/signup_footer.dart';
import 'package:our_companion_app/features/auth/provider/signup_provider.dart';
import 'package:our_companion_app/shared/widgets/app_button.dart';
import 'package:our_companion_app/shared/widgets/app_text_field.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = ref.watch(appColorsProvider);
    final signupState = ref.watch(signupProvider);

    final controller = SignupController(
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
                SignupHeader(otpSent: signupState.otpSent),

                if (!signupState.otpSent) ...[
                  SignupMethodTabs(
                    selectedMethod: signupState.signupMethod,
                    onMethodChanged: (method) {
                      ref.read(signupProvider.notifier).setSignupMethod(method);

                      _phoneController.clear();
                      _emailController.clear();
                    },
                  ),
                  const SizedBox(height: 32),
                ],

                if (signupState.signupMethod == SignupMethod.phone) ...[
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
                          readOnly: signupState.otpSent,
                          prefixIcon: Icons.phone_outlined,
                          validator: (value) {
                            if (signupState.signupMethod ==
                                SignupMethod.phone) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }

                              if (!RegExp(r'^[0-9]{10,12}$').hasMatch(value)) {
                                return 'Enter a valid 10-12 digit number';
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                      if (signupState.otpSent) ...[
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {
                            ref.read(signupProvider.notifier).editContact();

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
                ] else if (signupState.signupMethod == SignupMethod.email) ...[
                  Text(
                    'Email Address',
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
                          controller: _emailController,
                          hintText: 'Enter email address',
                          keyboardType: TextInputType.emailAddress,
                          readOnly: signupState.otpSent,
                          prefixIcon: Icons.email_outlined,
                          validator: (value) {
                            if (signupState.signupMethod ==
                                SignupMethod.email) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }

                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value.trim())) {
                                return 'Enter a valid email address';
                              }
                            }

                            return null;
                          },
                        ),
                      ),
                      if (signupState.otpSent) ...[
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {
                            ref.read(signupProvider.notifier).editContact();

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
                ],

                const SizedBox(height: 24),

                if (signupState.otpSent)
                  OtpSection(
                    signupState: signupState,
                    otpController: _otpController,
                    onResend: () => controller.sendOtp(
                      phone: _phoneController.text,
                      email: _emailController.text,
                    ),
                  ),

                if (signupState.isLoading)
                  Center(
                    child: CircularProgressIndicator(color: appColors.primary),
                  )
                else ...[
                  AppButton(
                    text: signupState.otpSent
                        ? 'Verify & Continue'
                        : 'Send OTP',
                    bgcolor: appColors.secondary,
                    height: 56,
                    width: double.infinity,
                    onPressed: signupState.otpSent
                        ? () => controller.verifyOtp(_otpController.text)
                        : () => controller.sendOtp(
                            phone: _phoneController.text,
                            email: _emailController.text,
                          ),
                  ),

                  const SizedBox(height: 20),

                  if (!signupState.otpSent) ...[
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 20),

                    GoogleSignInButton(onPressed: controller.googleSignIn),
                  ],
                ],

                const SizedBox(height: 30),

                const SignupFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
