import '../../domain/entities/place_entity.dart';
import '../../domain/repositories/place_search_repository.dart';
import '../datasources/place_search_remote_datasource.dart';

class PlaceSearchRepositoryImpl implements PlaceSearchRepository {
  final PlaceSearchRemoteDatasource remoteDatasource;

  PlaceSearchRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<PlaceEntity>> searchPlaces(String query) async {
    return await remoteDatasource.searchPlaces(query);
  }
}