import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/location_entity.dart';
import '../providers/location_provider.dart';

class LocationController extends AsyncNotifier<LocationEntity> {
  @override
  Future<LocationEntity> build() async {
    return ref.read(getCurrentLocationUseCaseProvider).call();
  }

  Future<void> getCurrentLocation() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return ref.read(getCurrentLocationUseCaseProvider).call();
    });
  }
}

final locationControllerProvider =
    AsyncNotifierProvider<LocationController, LocationEntity>(
  LocationController.new,
);