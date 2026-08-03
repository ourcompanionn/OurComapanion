import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/app/shared/auth/presentation/controller/signup_ui_state.dart';
import 'package:our_companion_app/app/shared/auth/presentation/provider/auth_provider.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/app/shared/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:our_companion_app/app/shared/auth/presentation/widgets/signup_method_tabs.dart';
import 'package:our_companion_app/app/shared/auth/presentation/widgets/signup_header.dart';
import 'package:our_companion_app/app/shared/auth/presentation/widgets/otp_section.dart';
import 'package:our_companion_app/app/shared/auth/presentation/widgets/signup_footer.dart';
import 'package:our_companion_app/app/shared/widgets/app_button.dart';
import 'package:our_companion_app/app/shared/widgets/app_text_field.dart';
import 'package:our_companion_app/app/shared/auth/domin/entities/user_role.dart';
import 'package:our_companion_app/app/shared/onboarding/presentation/providers/role_provider.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';

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
    final authState = ref.watch(authControllerProvider);
    final authController = ref.read(authControllerProvider.notifier);
    final signupState = ref.watch(signupUiProvider);
    final signupController = ref.read(signupUiProvider.notifier);

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
                      signupController.setSignupMethod(method);

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
                            signupController.editContact();

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
                            signupController.editContact();

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
                    onResend: () async {
                      await authController.requestOtp(_phoneController.text);
                      signupController.setOtpSent(true);
                    },
                  ),

                if (authState.isLoading)
                  Center(
                    child: CircularProgressIndicator(color: appColors.primary),
                  )
                else ...[
                  AppButton(
                    text: signupState.otpSent
                        ? 'Verify & Continue'
                        : 'Send OTP',
                    bgcolor: appColors.primary,
                    height: 56,
                    width: double.infinity,
                    onPressed: signupState.otpSent
                        ? () async {
                            if (!_formKey.currentState!.validate()) return;
                            await authController.verifyOtp(
                              phoneNumber: _phoneController.text,
                              otp: _otpController.text,
                              deviceIdentifier: "device-id",
                              platform: "Mobile",
                              deviceName: "Mobile Device",
                            );
                            final auth = ref.read(authControllerProvider).auth;

                            if (auth == null) return;

                            if (auth.isRegistrationRequired) {
                              if (mounted) {
                                context.go(AppRoutes.profileSetup);
                              }
                            } else {
                              if (mounted) {
                                final selectedRole = ref.read(roleProvider);
                                if (selectedRole == UserRole.worker) {
                                  context.go(AppRoutes.workerMain);
                                } else {
                                  context.go(AppRoutes.customerMain);
                                }
                              }
                            }
                          }
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              await authController.requestOtp(
                                _phoneController.text,
                              );
                              signupController.setOtpSent(true);
                            }
                          },
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

                    GoogleSignInButton(onPressed: () {}),
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
