import 'package:flutter/material.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/app/shared/request/provider/request_form_provider.dart';
import 'package:our_companion_app/app/customer/service_page/data/models/service_item.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/service_option_card.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/trip_details_card.dart';

class ExpandedServiceSelectSheet extends StatelessWidget {
  final AppColors appColors;
  final RequestFormState requestState;
  final RequestFormNotifier requestNotifier;
  final List<ServiceItem> services;
  final ScrollController scrollController;

  const ExpandedServiceSelectSheet({
    super.key,
    required this.appColors,
    required this.requestState,
    required this.requestNotifier,
    required this.services,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      padding: EdgeInsets.zero,
      children: [
        ...services.map((service) {
          final isSelected = requestState.selectedService == service.title;

          return ServiceOptionCard(
            service: service,
            isSelected: isSelected,
            appColors: appColors,
            onTap: () {
              requestNotifier.setSelectedService(
                service.title,
                icon: service.icon,
              );
            },
          );
        }),
        TripDetailsCard(
          pickupLocation: requestState.pickupLocation,
          destination: requestState.destination,
          appColors: appColors,
        ),
      ],
    );
  }
}
