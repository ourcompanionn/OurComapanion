import 'package:latlong2/latlong.dart';

import '../../domain/entities/route_entity.dart';
import '../../domain/repositories/route_repository.dart';
import '../datasources/route_remote_datasource.dart';

class RouteRepositoryImpl implements RouteRepository {
  final RouteRemoteDatasource remoteDatasource;

  RouteRepositoryImpl(this.remoteDatasource);

  @override
  Future<RouteEntity> getRoute({
    required LatLng pickup,
    required LatLng destination,
  }) {
    return remoteDatasource.getRoute(
      pickup: pickup,
      destination: destination,
    );
  }
}