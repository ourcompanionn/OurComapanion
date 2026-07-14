import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';
import 'package:our_companion_app/app/shared/request/provider/request_form_provider.dart';
import 'package:our_companion_app/app/customer/service_page/provider/service_provider.dart';
import 'package:our_companion_app/app/shared/widgets/custom_draggable_sheet.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/collapsed_service_select_sheet.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/service_select_expanded_view.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/fixed_bottom_action_bar.dart';

class CustomerServiceSelectPage extends ConsumerStatefulWidget {
  const CustomerServiceSelectPage({super.key});

  @override
  ConsumerState<CustomerServiceSelectPage> createState() =>
      _CustomerServiceSelectPageState();
}

class _CustomerServiceSelectPageState
    extends ConsumerState<CustomerServiceSelectPage> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  Future<void> _showDateTimePicker(
    BuildContext context,
    RequestFormState requestState,
    RequestFormNotifier requestNotifier,
  ) async {
    final date = await showDatePicker(
      context: context,
      initialDate: requestState.scheduleTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date != null && context.mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: requestState.scheduleTime != null
            ? TimeOfDay.fromDateTime(requestState.scheduleTime!)
            : TimeOfDay.now(),
      );
      if (time != null) {
        final selected = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
        requestNotifier.setScheduleTime(selected);
        requestNotifier.setRequestType(RequestType.schedule);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = ref.watch(appColorsProvider);
    final requestState = ref.watch(requestFormProvider);
    final requestNotifier = ref.read(requestFormProvider.notifier);
    final services = ref.watch(servicesListProvider);

    // Auto-select first service if none selected yet
    if (requestState.selectedService.isEmpty && services.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        requestNotifier.setSelectedService(
          services.first.title,
          icon: services.first.icon,
        );
      });
    }

    return Scaffold(
      backgroundColor: appColors.background,
      body: Stack(
        children: [
          // Styled Map/Background (consistent with request details)
          Positioned.fill(
            child: Container(
              color: appColors.bgLocation,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.map, size: 64, color: Colors.grey[500]),
                    const SizedBox(height: 8),
                    Text(
                      'Map Background (Dummy)',
                      style: GoogleFonts.poppins(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 22,
            left: 16,
            child: InkWell(
              onTap: () => context.pop(),
              borderRadius: BorderRadius.circular(24),
              child: CircleAvatar(
                backgroundColor: appColors.background,
                radius: 24,
                child: Icon(Icons.arrow_back, color: appColors.text),
              ),
            ),
          ),

          // Draggable Bottom Sheet
          CustomDraggableSheet(
            controller: _sheetController,
            initialChildSize: 0.6,
            minChildSize: 0.26,
            maxChildSize: 0.85,
            backgroundColor: appColors.seconderyBackground,
            builder: (context, scrollController) {
              return Column(
                children: [
                  Expanded(
                    child: AnimatedBuilder(
                      animation: _sheetController,
                      builder: (context, child) {
                        final currentSize = _sheetController.isAttached
                            ? _sheetController.size
                            : 0.6;
                        final isMinimized = currentSize < 0.3;

                        if (isMinimized) {
                          return CollapsedServiceSelectSheet(
                            appColors: appColors,
                            requestState: requestState,
                            services: services,
                            scrollController: scrollController,
                          );
                        }

                        return ServiceSelectExpandedView(
                          appColors: appColors,
                          requestState: requestState,
                          requestNotifier: requestNotifier,
                          services: services,
                          scrollController: scrollController,
                        );
                      },
                    ),
                  ),
                  // Fixed Action Bar
                  FixedBottomActionBar(
                    appColors: appColors,
                    isScheduled:
                        requestState.requestType == RequestType.schedule,
                    scheduleTime: requestState.scheduleTime,
                    onSchedulePressed: () => _showDateTimePicker(
                      context,
                      requestState,
                      requestNotifier,
                    ),
                    onCancelSchedule: () =>
                        requestNotifier.setRequestType(RequestType.instant),
                    onChoosePressed: () {
                      context.push(AppRoutes.customerRequestDetails);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
