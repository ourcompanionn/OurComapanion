import '../entities/place_entity.dart';

abstract class PlaceSearchRepository {
  Future<List<PlaceEntity>> searchPlaces(String query);
}