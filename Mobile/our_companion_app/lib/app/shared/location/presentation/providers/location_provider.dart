import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:our_companion_app/app/shared/location/data/datasources/place_search_remote_datasource.dart';
import 'package:our_companion_app/app/shared/location/data/repositories/place_search_repository_impl.dart';
import 'package:our_companion_app/app/shared/location/domain/repositories/place_search_repository.dart';
import 'package:our_companion_app/app/shared/location/domain/usecases/search_place_usecase.dart';
import 'package:our_companion_app/app/shared/location/presentation/controllers/location_search_controller.dart';
import 'package:our_companion_app/app/shared/location/presentation/controllers/location_search_state.dart';
import 'package:our_companion_app/app/shared/location/presentation/controllers/location_search_type.dart';
import 'package:our_companion_app/app/shared/location/presentation/controllers/map_location_controller.dart';
import 'package:our_companion_app/app/shared/location/presentation/controllers/map_location_state.dart';
import 'package:our_companion_app/core/providers/ors_dio_provider.dart';
import '../../data/datasources/location_local_datasource.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/usecases/get_current_location_usecase.dart';

final locationDatasourceProvider =
    Provider<LocationLocalDatasource>((ref) {
  return LocationLocalDatasourceImpl();
});

final locationRepositoryProvider =
    Provider<LocationRepository>((ref) {
  return LocationRepositoryImpl(
    ref.read(locationDatasourceProvider),
  );
});

final getCurrentLocationUseCaseProvider =
    Provider<GetCurrentLocationUseCase>((ref) {
  return GetCurrentLocationUseCase(
    ref.read(locationRepositoryProvider),
  );
});



// Place Search Datasource
final placeSearchDatasourceProvider =
    Provider<PlaceSearchRemoteDatasource>((ref) {
  return PlaceSearchRemoteDatasourceImpl(
    ref.read(orsDioProvider),
  );
});

// Place Search Repository
final placeSearchRepositoryProvider =
    Provider<PlaceSearchRepository>((ref) {
  return PlaceSearchRepositoryImpl(
    ref.read(placeSearchDatasourceProvider),
  );
});

// Search Place UseCase
final searchPlaceUseCaseProvider =
    Provider<SearchPlaceUseCase>((ref) {
  return SearchPlaceUseCase(
    ref.read(placeSearchRepositoryProvider),
  );
});

// Search Controller
final locationSearchControllerProvider =
    StateNotifierProvider<LocationSearchController, LocationSearchState>((ref) {
  return LocationSearchController(ref);
});

final mapLocationProvider =
    StateNotifierProvider<MapLocationController, MapLocationState>((ref) {
  return MapLocationController();
});

final activeSearchFieldProvider =
    StateProvider<SearchField>(
  (ref) => SearchField.destination,
);

final mapControllerProvider = Provider<MapController>((ref) {
  return MapController();
});