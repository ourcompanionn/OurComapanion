import 'package:latlong2/latlong.dart';

import '../../domain/entities/route_entity.dart';

class RouteModel extends RouteEntity {
  const RouteModel({
    required super.points,
    required super.distance,
    required super.duration,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    final route = json['routes'][0];

    final geometry = route['geometry'];

    final coordinates = geometry['coordinates'] as List;

    final points = coordinates.map((e) {
      return LatLng(
        (e[1] as num).toDouble(),
        (e[0] as num).toDouble(),
      );
    }).toList();

    return RouteModel(
      points: points,
      distance: (route['distance'] as num).toDouble(),
      duration: (route['duration'] as num).toDouble(),
    );
  }
}