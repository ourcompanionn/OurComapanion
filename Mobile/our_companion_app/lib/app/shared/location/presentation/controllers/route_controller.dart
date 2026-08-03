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
  print("GET ROUTE");
  print("Pickup: $pickup");
  print("Destination: $destination");

  state = const AsyncLoading();

  state = await AsyncValue.guard(() async {
    final route = await ref.read(getRouteUseCaseProvider).call(
      pickup: pickup,
      destination: destination,
    );

    print("Points count: ${route.points.length}");
    print("Distance: ${route.distance}");
    print("Duration: ${route.duration}");

    return route;
  });
}
}

final routeControllerProvider =
    AsyncNotifierProvider<RouteController, RouteEntity?>(
  RouteController.new,
);