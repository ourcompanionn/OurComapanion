import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/features/customer/service_page/presentation/widgets/service_card.dart';

class CustomerServicePage extends ConsumerWidget {
  const CustomerServicePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);

    return Scaffold(
      backgroundColor: appColors.background,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ListView(
              children: [
                Text(
                  'Services',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: appColors.secondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore available categories of companion services',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: appColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 32),

                Column(
                  children: const [
                    ServiceCard(
                      title: 'Hospital Companion',
                      icon: Icons.local_hospital_outlined,
                      description: 'Medical visits support',
                      imagePath: 'assets/images/hospital_companion_image.png',
                    ),
                    SizedBox(height: 16),
                    ServiceCard(
                      title: 'Shopping Companion',
                      icon: Icons.shopping_bag_outlined,
                      description: 'Grocery & store help',
                      imagePath: 'assets/images/shoping_companion.png',
                    ),
                    SizedBox(height: 16),
                    ServiceCard(
                      title: 'Travel Companion',
                      icon: Icons.flight_takeoff_outlined,
                      description: '',
                     imagePath: 'assets/images/travaling_companion.png', 
                    ),
                    SizedBox(height: 16),
                    ServiceCard(
                      title: 'Elderly Companion',
                      icon: Icons.elderly_outlined,
                      description: 'Social care & wellness',
                      imagePath: 'assets/images/companion_elders.png',
                    ),
                    SizedBox(height: 16),
                    ServiceCard(
                      title: 'Companion for Social Events',
                      icon: Icons.event_outlined,
                      description: 'Enjoy events together',
                    ),
                    SizedBox(height: 16),
                    ServiceCard(
                      title: 'Companion for Social Events',
                      icon: Icons.event_outlined,
                      description: 'Enjoy events together',
                    ),
                    SizedBox(height: 16),
                    ServiceCard(
                      title: 'Companion for Social Events',
                      icon: Icons.event_outlined,
                      description: 'Enjoy events together',
                    ),
                    SizedBox(height: 16),
                    ServiceCard(
                      title: 'Companion for Social Events',
                      icon: Icons.event_outlined,
                      description: 'Enjoy events together',
                    ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      // appColors.background,
                      appColors.background.withOpacity(0.9),
                      appColors.background.withOpacity(0.95),
                      appColors.background.withOpacity(0.2),

                      // Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
