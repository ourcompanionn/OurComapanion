import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_companion_app/app/shared/request/provider/dio_provider.dart';
import 'package:our_companion_app/core/network/api_endpont.dart';
import 'package:our_companion_app/app/shared/request/data/model/customer_request_model.dart';
import 'package:our_companion_app/app/shared/request/data/model/response_model.dart';

class RequestRemoteDataSource {
  final Dio dio;

  RequestRemoteDataSource(this.dio);

  Future<RequestResponseModel> createRequest(RequestModel model) async {
    final response = await dio.post(
      ApiEndpoints.register,
      data: model.toJson(),
    );

    return RequestResponseModel.fromJson(response.data);
  }
}

final requestRemoteDataSourceProvider = Provider<RequestRemoteDataSource>((
  ref,
) {
  return RequestRemoteDataSource(ref.read(dioProviders));
});
