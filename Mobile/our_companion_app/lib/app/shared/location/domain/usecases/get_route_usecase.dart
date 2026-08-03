import 'package:latlong2/latlong.dart';

import '../entities/route_entity.dart';
import '../repositories/route_repository.dart';

class GetRouteUseCase {
  final RouteRepository repository;

  GetRouteUseCase(this.repository);

  Future<RouteEntity> call({
    required LatLng pickup,
    required LatLng destination,
  }) {
    return repository.getRoute(
      pickup: pickup,
      destination: destination,
    );
  }
}