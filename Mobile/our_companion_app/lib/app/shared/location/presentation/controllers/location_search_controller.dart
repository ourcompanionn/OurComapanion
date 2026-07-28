import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:our_companion_app/app/shared/location/presentation/controllers/location_search_type.dart';

import '../providers/location_provider.dart';
import 'location_search_state.dart';

class LocationSearchController extends StateNotifier<LocationSearchState> {
  final Ref ref;

  LocationSearchController(this.ref) : super(const LocationSearchState());

  Future<void> searchPlaces(String query) async {
    if (query.trim().isEmpty) {
      state = state.copyWith(places: [], isSearching: false);
      return;
    }

    state = state.copyWith(isSearching: true);

    try {
      final places = await ref.read(searchPlaceUseCaseProvider).call(query);

      state = state.copyWith(places: places, isSearching: false);
    } catch (_) {
      state = state.copyWith(places: [], isSearching: false);
    }
  }

  void clearSearch() {
    state = const LocationSearchState();
  }




}
