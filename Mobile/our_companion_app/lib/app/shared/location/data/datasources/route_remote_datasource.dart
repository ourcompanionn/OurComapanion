import 'package:latlong2/latlong.dart';

import '../models/route_model.dart';

abstract class RouteRemoteDatasource {
  Future<RouteModel> getRoute({
    required LatLng pickup,
    required LatLng destination,
  });
}