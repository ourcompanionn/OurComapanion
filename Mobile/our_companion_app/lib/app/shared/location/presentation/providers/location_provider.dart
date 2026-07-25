import 'package:flutter_riverpod/flutter_riverpod.dart';

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