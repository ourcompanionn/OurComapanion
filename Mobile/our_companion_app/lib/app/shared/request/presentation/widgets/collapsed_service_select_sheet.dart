import 'package:flutter/material.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/app/shared/request/provider/request_form_provider.dart';
import 'package:our_companion_app/app/customer/service_page/data/models/service_item.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/service_option_card.dart';

class CollapsedServiceSelectSheet extends StatelessWidget {
  final AppColors appColors;
  final RequestFormState requestState;
  final List<ServiceItem> services;
  final ScrollController scrollController;

  const CollapsedServiceSelectSheet({
    super.key,
    required this.appColors,
    required this.requestState,
    required this.services,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final ServiceItem? selectedServiceItem = services.isEmpty
        ? null
        : services.firstWhere(
            (s) => s.title == requestState.selectedService,
            orElse: () => services.first,
          );

    return SingleChildScrollView(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
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
            if (selectedServiceItem != null)
              ServiceOptionCard(
                service: selectedServiceItem,
                isSelected: true,
                appColors: appColors,
                onTap: () {}, // No action in collapsed view
              ),
          ],
        ),
      ),
    );
  }
}
