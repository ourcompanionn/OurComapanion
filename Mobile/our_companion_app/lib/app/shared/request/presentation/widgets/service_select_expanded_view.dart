import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/app/shared/request/provider/request_form_provider.dart';
import 'package:our_companion_app/app/customer/service_page/data/models/service_item.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/expanded_service_select_sheet.dart';

class ServiceSelectExpandedView extends StatelessWidget {
  final AppColors appColors;
  final RequestFormState requestState;
  final RequestFormNotifier requestNotifier;
  final List<ServiceItem> services;
  final ScrollController scrollController;
  const ServiceSelectExpandedView({
    super.key,
    required this.appColors,
    required this.requestState,
    required this.requestNotifier,
    required this.services,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top section with drag handle & header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'Choose Service',
                style: GoogleFonts.poppins(
                  color: appColors.text,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),

        // Scrollable list of services & location
        Expanded(
          child: ExpandedServiceSelectSheet(
            appColors: appColors,
            requestState: requestState,
            requestNotifier: requestNotifier,
            services: services,
            scrollController: scrollController,
          ),
        ),

      ],
    );
  }
}
