import 'package:flutter_riverpod/legacy.dart';

enum RequestFlowState { initial, searching, accepted }

class RequestFlowController extends StateNotifier<RequestFlowState> {
  RequestFlowController() : super(RequestFlowState.initial);

  Future<void> confirmRequest() async {
    state = RequestFlowState.searching;
    await Future.delayed(const Duration(seconds: 3));
    state = RequestFlowState.accepted;
  }

  void reset() {
    state = RequestFlowState.initial;
  }
}

final requestFlowProvider =
    StateNotifierProvider.autoDispose<RequestFlowController, RequestFlowState>((
      ref,
    ) {
      return RequestFlowController();
    });
