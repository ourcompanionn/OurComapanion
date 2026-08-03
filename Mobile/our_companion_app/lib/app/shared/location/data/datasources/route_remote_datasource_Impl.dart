import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

import 'package:our_companion_app/core/constents/open_route_service.dart';
import 'package:our_companion_app/app/shared/location/data/models/route_model.dart';
import 'package:our_companion_app/app/shared/location/data/datasources/route_remote_datasource.dart';

class RouteRemoteDatasourceImpl implements RouteRemoteDatasource {
  final Dio dio;

  RouteRemoteDatasourceImpl(this.dio);

  // @override
  // Future<RouteModel> getRoute({
  //   required LatLng pickup,
  //   required LatLng destination,
  // }) async {
  //   try {
  //     final response = await dio.post(
  //       OpenRouteService.baseUrl,
  //       options: Options(
  //         headers: {
  //           "Authorization": OpenRouteService.apiKey,
  //           "Content-Type": "application/json",
  //         },
  //       ),
  //       data: {
  //         "coordinates": [
  //           [pickup.longitude, pickup.latitude],
  //           [destination.longitude, destination.latitude],
  //         ]
  //       },
  //     );

  //     print(response.data);

  //     return RouteModel.fromJson(response.data);
  //   } on DioException catch (e) {
  //     print("Status: ${e.response?.statusCode}");
  //     print("Body: ${e.response?.data}");
  //     rethrow;
  //   }
  // }

  @override
  Future<RouteModel> getRoute({
    required LatLng pickup,
    required LatLng destination,
  }) async {
    print("===== ROUTE API START =====");

    print("Pickup: ${pickup.latitude}, ${pickup.longitude}");
    print("Destination: ${destination.latitude}, ${destination.longitude}");

    print("URL: ${OpenRouteService.baseUrl}");
    print("API KEY: ${OpenRouteService.apiKey}");

    try {
      final response = await dio.post(
        OpenRouteService.baseUrl,
        options: Options(
          headers: {
            "Authorization": OpenRouteService.apiKey,
            "Content-Type": "application/json",
          },
        ),
        data: {
          "coordinates": [
            [pickup.longitude, pickup.latitude],
            [destination.longitude, destination.latitude],
          ],
          "format": "geojson",
        },
      );

      print("STATUS: ${response.statusCode}");
      print("BODY:");
      print(response.data);
      print("Geometry type: ${response.data['routes'][0]['geometry'].runtimeType}");
print("Geometry: ${response.data['routes'][0]['geometry']}");

      return RouteModel.fromJson(response.data);
    } catch (e, s) {
      print("ERROR:");
      print(e);
      print(s);
      rethrow;
    }
  }
}
