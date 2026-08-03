import 'package:latlong2/latlong.dart';

class MapLocationState {
  final LatLng? pickup;
  final LatLng? destination;

  const MapLocationState({
    this.pickup,
    this.destination,
  });

  MapLocationState copyWith({
    LatLng? pickup,
    LatLng? destination,
  }) {
    return MapLocationState(
      pickup: pickup ?? this.pickup,
      destination: destination ?? this.destination,
    );
  }
}