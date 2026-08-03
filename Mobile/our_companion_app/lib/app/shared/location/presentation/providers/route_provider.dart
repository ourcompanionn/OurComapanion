

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_companion_app/app/shared/location/data/datasources/route_remote_datasource.dart';
import 'package:our_companion_app/app/shared/location/data/datasources/route_remote_datasource_Impl.dart';
import 'package:our_companion_app/app/shared/location/data/repositories/route_repository_impl.dart';
import 'package:our_companion_app/app/shared/location/domain/repositories/route_repository.dart';
import 'package:our_companion_app/app/shared/location/domain/usecases/get_route_usecase.dart';
import 'package:our_companion_app/core/providers/ors_dio_provider.dart';


final routeDatasourceProvider =
    Provider<RouteRemoteDatasource>((ref) {
  return RouteRemoteDatasourceImpl(
    ref.read(orsDioProvider),
  );
});

final routeRepositoryProvider =
    Provider<RouteRepository>((ref) {
  return RouteRepositoryImpl(
    ref.read(routeDatasourceProvider),
  );
});

final getRouteUseCaseProvider =
    Provider<GetRouteUseCase>((ref) {
  return GetRouteUseCase(
    ref.read(routeRepositoryProvider),
  );
});