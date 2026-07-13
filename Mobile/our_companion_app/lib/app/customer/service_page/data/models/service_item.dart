import 'package:flutter/widgets.dart';

class ServiceItem {
  final String title;
  final IconData icon;
  final String description;
  final String imagePath;

  const ServiceItem({
    required this.title,
    required this.icon,
    required this.description,
    required this.imagePath,
  });
}
