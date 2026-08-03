import 'package:latlong2/latlong.dart';

import '../entities/route_entity.dart';

abstract class RouteRepository {
  Future<RouteEntity> getRoute({
    required LatLng pickup,
    required LatLng destination,
  });
}