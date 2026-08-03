import 'package:flutter_riverpod/legacy.dart';
import 'package:latlong2/latlong.dart';

import 'map_location_state.dart';

class MapLocationController extends StateNotifier<MapLocationState> {
  MapLocationController() : super(const MapLocationState());

  void setPickup(LatLng location) {
    state = state.copyWith(pickup: location);
  }

  void setDestination(LatLng location) {
    state = state.copyWith(destination: location);
  }

  void clearDestination() {
    state = state.copyWith(destination: null);
  }

  void clearAll() {
    state = const MapLocationState();
  }
}

