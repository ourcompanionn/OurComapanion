import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/features/customer/home_page/widgets/customer_search_location.dart';
import 'package:our_companion_app/core/providers/theme_provider.dart';

class CustomerHomePage extends ConsumerStatefulWidget {  
  const CustomerHomePage({super.key});

  @override
  ConsumerState<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends ConsumerState<CustomerHomePage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    final appColors = ref.watch(appColorsProvider);

    return Scaffold(
      backgroundColor: appColors.background,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello User",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: appColors.text,
                    ),
                  ),
                  Text(
                    "Find the best companion",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: appColors.secondaryText,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: isDarkMode ? Colors.yellow : Colors.grey[800],
                ),
                onPressed: () {  
                  ref.read(themeProvider.notifier).state = isDarkMode
                      ? ThemeMode.light
                      : ThemeMode.dark;
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomerSearchLocation(),
        ],
      ),
    );
  }
}
