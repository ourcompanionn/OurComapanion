import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:our_companion_app/core/constents/maptiler.dart';
import 'package:our_companion_app/app/shared/location/data/models/route_model.dart';
import 'package:our_companion_app/app/shared/location/data/datasources/route_remote_datasource.dart'; // ✅ only this, no local redeclaration

class RouteRemoteDatasourceImpl implements RouteRemoteDatasource {
  final Dio dio;

  RouteRemoteDatasourceImpl(this.dio);

  @override
  Future<RouteModel> getRoute({
    required LatLng pickup,
    required LatLng destination,
  }) async {
    final response = await dio.get(
      "https://api.maptiler.com/routes/v2/driving/"
      "${pickup.longitude},${pickup.latitude};"
      "${destination.longitude},${destination.latitude}",
      queryParameters: {
        "key": MapTiler.apiKey,
        "geometry": "geojson",
      },
    );

    return RouteModel.fromJson(response.data);
  }
}