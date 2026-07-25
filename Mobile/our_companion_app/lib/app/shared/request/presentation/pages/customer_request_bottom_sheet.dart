import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/app/shared/location/presentation/controllers/location_controller.dart';
import 'package:our_companion_app/app/shared/location/presentation/widget/current_location_map.dart';
import 'package:our_companion_app/app/shared/request/presentation/controller/location_field_controller.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/app/shared/request/provider/request_form_provider.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/request_type_chip.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/set_location_field.dart';
import 'package:our_companion_app/app/shared/widgets/custom_draggable_sheet.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/customer_request_collapsed_view.dart';

class CustomerRequestBottomSheet extends ConsumerStatefulWidget {
  const CustomerRequestBottomSheet({super.key});

  @override
  ConsumerState<CustomerRequestBottomSheet> createState() =>
      _CustomerRequestBottomSheetState();
}

class _CustomerRequestBottomSheetState
    extends ConsumerState<CustomerRequestBottomSheet> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();


      @override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    final location = ref.read(locationControllerProvider);

    location.whenData((data) {
      ref
          .read(locationFieldControllerProvider)
          .setPickupLocation(data.address);
    });
  });
}

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  Widget _buildExpandedContent(
    AppColors appColors,
    RequestFormState requestState,
    RequestFormNotifier requestNotifier,
  ) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: appColors.secondaryText.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 8),

            Text(
              'Plan your request',
              style: GoogleFonts.poppins(
                color: appColors.text,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                RequestTypeChip(
                  icon: Icons.schedule,
                  label: 'Instant',
                  appColors: appColors,
                  isSelected: requestState.requestType == RequestType.instant,
                  onTap: () {
                    requestNotifier.setRequestType(RequestType.instant);
                  },
                ),
                const SizedBox(width: 12),
                RequestTypeChip(
                  icon: Icons.calendar_today,
                  label: 'Schedule',
                  appColors: appColors,
                  isSelected: requestState.requestType == RequestType.schedule,
                  onTap: () {
                    requestNotifier.setRequestType(RequestType.schedule);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            SetLocationField(),
            const SizedBox(height: 24),
            ListTile(
              leading: Icon(
                Icons.location_on_outlined,
                color: appColors.secondaryText,
              ),
              title: Text(
                'Set location on map',
                style: GoogleFonts.poppins(
                  color: appColors.text,
                  fontWeight: FontWeight.w500,
                ),
              ),
              contentPadding: EdgeInsets.zero,
              onTap: () {},
            ),
            Divider(color: appColors.border),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appColors = ref.watch(appColorsProvider);
    final requestState = ref.watch(requestFormProvider);
    final requestNotifier = ref.read(requestFormProvider.notifier);
    final location = ref.watch(locationControllerProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Styled Map/Background
          Positioned.fill(
            child: const CurrentLocationMap()
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
            initialChildSize: 0.9,
            minChildSize: 0.28,
            maxChildSize: 0.9,
            snap: true,
            snapSizes: const [0.28, 0.9],
            backgroundColor: appColors.seconderyBackground,
            builder: (context, scrollController) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: AnimatedBuilder(
                    animation: _sheetController,
                    builder: (context, child) {
                      final currentSize = _sheetController.isAttached
                          ? _sheetController.size
                          : 0.9;
                      final isMinimized = currentSize < 0.4;

                      return AnimatedCrossFade(
                        duration: const Duration(milliseconds: 300),
                        crossFadeState: isMinimized
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        firstChild: const CustomerRequestCollapsedView(),
                        secondChild: _buildExpandedContent(
                          appColors,
                          requestState,
                          requestNotifier,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
