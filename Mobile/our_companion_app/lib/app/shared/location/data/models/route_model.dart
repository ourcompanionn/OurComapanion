import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entities/route_entity.dart';

class RouteModel extends RouteEntity {
  const RouteModel({
    required super.points,
    required super.distance,
    required super.duration,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    final route = json["routes"][0];

    final summary = route["summary"];

    final encodedPolyline = route["geometry"] as String;

    final decodedPoints =
      PolylinePoints().decodePolyline(encodedPolyline);

    final points = decodedPoints
        .map(
          (p) => LatLng(
            p.latitude,
            p.longitude,
          ),
        )
        .toList();

    return RouteModel(
      points: points,
      distance: (summary["distance"] as num).toDouble(),
      duration: (summary["duration"] as num).toDouble(),
    );
  }
}