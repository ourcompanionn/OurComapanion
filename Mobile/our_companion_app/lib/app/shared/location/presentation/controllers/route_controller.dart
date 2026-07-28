import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entities/route_entity.dart';
import '../providers/route_provider.dart';

class RouteController extends AsyncNotifier<RouteEntity?> {

  @override
  Future<RouteEntity?> build() async {
    return null;
  }

  Future<void> getRoute({
    required LatLng pickup,
    required LatLng destination,
  }) async {

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {

      return ref.read(getRouteUseCaseProvider).call(
        pickup: pickup,
        destination: destination,
      );

    });
  }
}

final routeControllerProvider =
    AsyncNotifierProvider<RouteController, RouteEntity?>(
  RouteController.new,
);