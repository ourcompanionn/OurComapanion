import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_local_datasource.dart';

class LocationRepositoryImpl
    implements LocationRepository {

  final LocationLocalDatasource datasource;

  LocationRepositoryImpl(this.datasource);

  @override
  Future<LocationEntity> getCurrentLocation() {
    return datasource.getCurrentLocation();
  }
}