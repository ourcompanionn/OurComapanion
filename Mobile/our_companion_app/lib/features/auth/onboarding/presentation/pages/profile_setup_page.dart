import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/features/auth/onboarding/presentation/controller/profile_setup_controller.dart';
import 'package:our_companion_app/features/auth/onboarding/presentation/providers/signup_provider.dart';
import 'package:our_companion_app/features/auth/onboarding/presentation/widgets/gender_card.dart';
import 'package:our_companion_app/shared/widgets/app_button.dart';
import 'package:our_companion_app/shared/widgets/app_text_field.dart';

class ProfileSetupPage extends ConsumerStatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  ConsumerState<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends ConsumerState<ProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = ref.watch(appColorsProvider);
    final signupState = ref.watch(signupProvider);
    final controller = ProfileSetupController(
      ref: ref,
      context: context,
      formKey: _formKey,
    );

    return Scaffold(
      backgroundColor: appColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appColors.secondary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Setup',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: appColors.secondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tell us a bit about yourself to get started',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 40),

                Text(
                  'Full Name',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                AppTextField(
                  controller: _nameController,
                  hintText: 'Enter your full name',
                  prefixIcon: Icons.person_outline,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),

                if (signupState.signupMethod == SignupMethod.phone) ...[
                  Text(
                    'Email Address',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: _emailController,
                    hintText: 'Enter your email address',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value.trim())) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 28),
                ] else ...[
                  Text(
                    'Phone Number',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: _phoneController,
                    hintText: 'Enter your phone number',
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
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
                  const SizedBox(height: 28),
                ],

                Text(
                  'Gender',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    GenderCard(
                      label: 'Male',
                      icon: Icons.male_outlined,
                      isSelected: signupState.gender == 'Male',
                      onTap: () =>
                          ref.read(signupProvider.notifier).setGender('Male'),
                    ),
                    const SizedBox(width: 12),
                    GenderCard(
                      label: 'Female',
                      icon: Icons.female_outlined,
                      isSelected: signupState.gender == 'Female',
                      onTap: () =>
                          ref.read(signupProvider.notifier).setGender('Female'),
                    ),
                    const SizedBox(width: 12),
                    GenderCard(
                      label: 'Other',
                      icon: Icons.transgender_outlined,
                      isSelected: signupState.gender == 'Other',
                      onTap: () =>
                          ref.read(signupProvider.notifier).setGender('Other'),
                    ),
                  ],
                ),
                const SizedBox(height: 50),

                if (signupState.isLoading)
                  Center(
                    child: CircularProgressIndicator(color: appColors.accent),
                  )
                else
                  AppButton(
                    text: 'Continue',
                    bgcolor: appColors.primary,
                    height: 56,
                    width: double.infinity,
                    onPressed: () => controller.onContinue(
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
