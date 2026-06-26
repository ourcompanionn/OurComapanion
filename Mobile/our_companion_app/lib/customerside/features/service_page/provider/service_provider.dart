import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_companion_app/customerside/features/service_page/data/models/service_item.dart';

final servicesListProvider = Provider<List<ServiceItem>>((ref) {
  return const [
    ServiceItem(
      title: 'Hospital\nCompanion',
      icon: Icons.local_hospital_outlined,
      description:
          'Providing support during hospital visits, medical appointments, and healthcare procedures to ensure a comfortable and stress-free experience.',
      imagePath: 'assets/images/hospital_companion_image.png',
    ),
    ServiceItem(
      title: 'Shopping\nCompanion',
      icon: Icons.shopping_bag_outlined,
      description:
          'Helping with shopping trips, errands, and everyday purchases, making outings easier, more convenient, and enjoyable.',
      imagePath: 'assets/images/shoping_companion.png',
    ),
    ServiceItem(
      title: 'Travel\nCompanion',
      icon: Icons.flight_takeoff_outlined,
      description:
          'Offering reliable assistance during local and long-distance travel, ensuring a safe, comfortable, and worry-free journey.',
      imagePath: 'assets/images/travaling_companion.png',
    ),
    ServiceItem(
      title: 'Elderly\nCompanion',
      icon: Icons.elderly_outlined,
      description:
          'Providing caring companionship and daily support to help seniors stay active, independent, and socially connected.',
      imagePath: 'assets/images/companion_elders.png',
    ),
  ];
});

class ServiceSearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void updateQuery(String value) {
    state = value;
  }
}

final serviceSearchQueryProvider = NotifierProvider<ServiceSearchQueryNotifier, String>(
  ServiceSearchQueryNotifier.new,
);

final filteredServicesProvider = Provider<List<ServiceItem>>((ref) {
  final allServices = ref.watch(servicesListProvider);
  final searchQuery = ref.watch(serviceSearchQueryProvider).toLowerCase();

  if (searchQuery.isEmpty) {
    return allServices;
  }

  return allServices.where((service) {
    final title = service.title.replaceAll('\n', ' ').toLowerCase();
    final desc = service.description.toLowerCase();
    return title.contains(searchQuery) || desc.contains(searchQuery);
  }).toList();
});
