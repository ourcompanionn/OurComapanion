import '../../domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.latitude,
    required super.longitude,
    required super.address,
    required super.locality,
    required super.subLocality,
  });
}