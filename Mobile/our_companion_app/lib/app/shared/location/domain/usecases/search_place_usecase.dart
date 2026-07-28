import '../entities/place_entity.dart';
import '../repositories/place_search_repository.dart';

class SearchPlaceUseCase {
  final PlaceSearchRepository repository;

  SearchPlaceUseCase(this.repository);

  Future<List<PlaceEntity>> call(String query) async {
    return await repository.searchPlaces(query);
  }
}