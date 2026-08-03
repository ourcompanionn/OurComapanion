import 'package:dio/dio.dart';
import 'package:our_companion_app/core/constents/maptiler.dart';

import '../models/place_model.dart';

abstract class PlaceSearchRemoteDatasource {
  Future<List<PlaceModel>> searchPlaces(String query);
}

class PlaceSearchRemoteDatasourceImpl implements PlaceSearchRemoteDatasource {
  final Dio dio;

  PlaceSearchRemoteDatasourceImpl(this.dio);

  @override
  Future<List<PlaceModel>> searchPlaces(String query) async {
    final response = await dio.get(
      "https://api.maptiler.com/geocoding/$query.json",
      queryParameters: {"key": MapTiler.apiKey, "limit": 10},
    );

final data = response.data["features"] as List;

    return data
    .map((e) => PlaceModel.fromJson(e))
    .toList();
  }
}
