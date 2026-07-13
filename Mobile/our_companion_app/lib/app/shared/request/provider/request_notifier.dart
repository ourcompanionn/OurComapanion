import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_companion_app/app/shared/request/data/model/customer_request_model.dart';
import 'package:our_companion_app/app/shared/request/data/model/response_model.dart';
import 'package:our_companion_app/app/shared/request/data/repository/request_repo.dart';

class RequestNotifier extends AsyncNotifier<RequestResponseModel?> {
  @override
  Future<RequestResponseModel?> build() async {
    return null;
  }

  Future<void> submit(RequestModel model) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return ref.read(requestRepositoryProvider).createRequest(model);
    });
  }
}

final requestProvider =
    AsyncNotifierProvider<RequestNotifier, RequestResponseModel?>(
      RequestNotifier.new,
    );
