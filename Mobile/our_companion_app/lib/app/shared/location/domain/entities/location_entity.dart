class LocationEntity {
  final double latitude;
  final double longitude;
  final String address;
  final String locality;
  final String subLocality;

  const LocationEntity({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.locality,
    required this.subLocality,
  });
}