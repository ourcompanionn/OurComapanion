import 'package:flutter/material.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/app/shared/request/provider/request_form_provider.dart';
import 'package:our_companion_app/app/shared/request/presentation/controller/request_flow_controller.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/searching_view.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/accepted_view.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/initial_form.dart';

class SheetContent extends StatelessWidget {
  final RequestFlowState flowState;
  final RequestFlowController flowNotifier;
  final AppColors appColors;
  final RequestFormState requestState;
  final RequestFormNotifier requestNotifier;
  final ScrollController scrollController;

  const SheetContent({
    super.key,
    required this.flowState,
    required this.flowNotifier,
    required this.appColors,
    required this.requestState,
    required this.requestNotifier,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (flowState == RequestFlowState.searching) {
      return SearchingView(appColors: appColors);
    } else if (flowState == RequestFlowState.accepted) {
      return AcceptedView(
        appColors: appColors,
        scrollController: scrollController,
      );
    } else {
      return InitialForm(
        appColors: appColors,
        requestState: requestState,
        requestNotifier: requestNotifier,
        scrollController: scrollController,
        flowNotifier: flowNotifier,
      );
    }
  }
}
