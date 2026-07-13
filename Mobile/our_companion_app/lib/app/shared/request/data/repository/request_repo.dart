import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_companion_app/app/shared/request/data/datasource/request_remote_datasource.dart';
import 'package:our_companion_app/app/shared/request/data/model/customer_request_model.dart';
import 'package:our_companion_app/app/shared/request/data/model/response_model.dart';

class RequestRepository {
  final RequestRemoteDataSource remote;

  RequestRepository(this.remote);

  Future<RequestResponseModel> createRequest(RequestModel model) {
    return remote.createRequest(model);
  }
}

final requestRepositoryProvider = Provider<RequestRepository>((ref) {
  return RequestRepository(ref.read(requestRemoteDataSourceProvider));
});
