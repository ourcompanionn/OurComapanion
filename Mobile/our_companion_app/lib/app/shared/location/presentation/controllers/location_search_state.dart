import 'package:our_companion_app/app/shared/location/presentation/controllers/location_search_type.dart';

import '../../domain/entities/place_entity.dart';

class LocationSearchState {
  final List<PlaceEntity> places;
  final bool isSearching;
  final SearchField? activeField;

  const LocationSearchState({
    this.places = const [],
    this.isSearching = false,
    this.activeField,
  });

  LocationSearchState copyWith({
    List<PlaceEntity>? places,
    bool? isSearching,
    SearchField? activeField,
  }) {
    return LocationSearchState(
      places: places ?? this.places,
      isSearching: isSearching ?? this.isSearching,
      activeField: activeField ?? this.activeField,
    );
  }
}