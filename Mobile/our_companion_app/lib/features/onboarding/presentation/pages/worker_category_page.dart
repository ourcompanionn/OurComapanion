import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/features/auth/provider/signup_provider.dart';
import 'package:our_companion_app/features/onboarding/presentation/controller/worker_category_controller.dart';
import 'package:our_companion_app/features/onboarding/presentation/widgets/category_card.dart';
import 'package:our_companion_app/features/onboarding/presentation/widgets/category_chip.dart';
import 'package:our_companion_app/shared/widgets/app_button.dart';

class WorkerCategoryPage extends ConsumerWidget {
  const WorkerCategoryPage({super.key});

  final List<String> _companionServices = const [
    'Hospital Companion',
    'Shopping Companion',
    'Travel Companion',
    'Elderly Companion',
  ];

  final List<String> _skilledServices = const [
    'Plumbing',
    'Wiring',
    'Painting',
    'Gardening',
    'Carpentry',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    final signupState = ref.watch(signupProvider);

    return Scaffold(
      backgroundColor: appColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose Services',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: appColors.secondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select the job categories you specialize in',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),

              // Companion Assist Category
              CategoryCard(
                title: 'Companion Assist',
                description:
                    'Support with hospital visits, shopping, and companionship',
                icon: Icons.people_outline,
                isExpanded: signupState.showCompanion,
                onTap: () =>
                    ref.read(signupProvider.notifier).toggleCompanion(),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: _companionServices.map((service) {
                    final isSelected = signupState.selectedCategories.contains(
                      service,
                    );
                    return CategoryChip(
                      label: service,
                      isSelected: isSelected,
                      onTap: () => ref
                          .read(signupProvider.notifier)
                          .toggleCategory(service),
                    );
                  }).toList(),
                ),
              ),

              CategoryCard(
                title: 'Skilled Work',
                description:
                    'Technical tasks like plumbing, electric wiring, and painting',
                icon: Icons.build_outlined,
                isExpanded: signupState.showSkilled,
                onTap: () => ref.read(signupProvider.notifier).toggleSkilled(),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: _skilledServices.map((service) {
                    final isSelected = signupState.selectedCategories.contains(
                      service,
                    );
                    return CategoryChip(
                      label: service,
                      isSelected: isSelected,
                      onTap: () => ref
                          .read(signupProvider.notifier)
                          .toggleCategory(service),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 48),

              if (signupState.isLoading)
                Center(
                  child: CircularProgressIndicator(color: appColors.accent),
                )
              else
                AppButton(
                  text: 'Complete Setup',
                  bgcolor: appColors.primary,
                  height: 56,
                  width: double.infinity,
                  onPressed: () {
                    WorkerCategoryController(
                      ref: ref,
                      context: context,
                    ).onComplete();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
