import '../../domain/entities/place_entity.dart';

class PlaceModel extends PlaceEntity {
  const PlaceModel({
    required super.name,
    required super.address,
    required super.latitude,
    required super.longitude,
  });

 factory PlaceModel.fromJson(Map<String, dynamic> json) {
  final center = json["center"] as List;

  return PlaceModel(
    name: json["text"] ?? "",
    address: json["place_name"] ?? "",
    latitude: (center[1] as num).toDouble(),
    longitude: (center[0] as num).toDouble(),
  );
 }
}