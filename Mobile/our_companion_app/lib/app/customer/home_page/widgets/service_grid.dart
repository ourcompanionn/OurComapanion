import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_companion_app/app/customer/home_page/widgets/home_service_card.dart';
import 'package:our_companion_app/app/customer/service_page/provider/service_provider.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class ServiceGrid extends ConsumerWidget {
  const ServiceGrid({super.key, required this.appColors});

  final AppColors appColors;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(servicesListProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: services.map((service) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: HomeServiceCard(appColors: appColors, service: service),
            ),
          );
        }).toList(),
      ),
    );
  }
}
