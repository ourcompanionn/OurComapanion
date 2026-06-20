import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryService {
  List<String> getCompanionServices() {
    return const [
      'Hospital Companion',
      'Shopping Companion',
      'Travel Companion',
      'Elderly Companion',
    ];
  }

  List<String> getSkilledServices() {
    return const [
      'Plumbing',
      'Wiring',
      'Painting',
      'Gardening',
      'Carpentry',
    ];
  }
}

final categoryServiceProvider = Provider<CategoryService>((ref) {
  return CategoryService();
});
