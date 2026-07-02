import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/customerside/features/service_page/presentation/widgets/service_card.dart';
import 'package:our_companion_app/customerside/features/service_page/provider/service_provider.dart';
import 'package:our_companion_app/shared/widgets/app_text_field.dart';

class CustomerServicePage extends ConsumerStatefulWidget {
  const CustomerServicePage({super.key});

  @override
  ConsumerState<CustomerServicePage> createState() =>
      _CustomerServicePageState();
}

class _CustomerServicePageState extends ConsumerState<CustomerServicePage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = ref.watch(appColorsProvider);
    final searchQuery = ref.watch(serviceSearchQueryProvider);
    final filteredServices = ref.watch(filteredServicesProvider);

    return Scaffold(
      backgroundColor: appColors.background,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
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
                const SizedBox(height: 24),

                AppTextField(
                  controller: _searchController,
                  hintText: 'Search for services...',
                  prefixIcon: Icons.search,
                  onChanged: (value) {
                    ref
                        .read(serviceSearchQueryProvider.notifier)
                        .updateQuery(value);
                  },
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: appColors.secondaryText,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            ref
                                .read(serviceSearchQueryProvider.notifier)
                                .updateQuery('');
                          },
                        )
                      : null,
                ),
                const SizedBox(height: 32),

                if (filteredServices.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_outlined,
                            size: 64,
                            color: appColors.secondaryText.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No services found',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: appColors.text,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "We couldn't find any results for '$searchQuery'",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: appColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Column(
                    children: filteredServices.map((service) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ServiceCard(
                          title: service.title,
                          icon: service.icon,
                          description: service.description,
                          imagePath: service.imagePath,
                        ),
                      );
                    }).toList(),
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
                      appColors.background.withValues(alpha: 0.9),
                      appColors.background.withValues(alpha: 0.95),
                      appColors.background.withValues(alpha: 0.2),
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
