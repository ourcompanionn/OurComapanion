import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';
import 'package:our_companion_app/app/shared/request/provider/request_form_provider.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/request_type_chip.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/set_location_field.dart';
import 'package:our_companion_app/app/shared/widgets/app_button.dart';

class CustomerRequestBottomSheet extends ConsumerStatefulWidget {
  const CustomerRequestBottomSheet({super.key});

  @override
  ConsumerState<CustomerRequestBottomSheet> createState() =>
      _CustomerRequestBottomSheetState();
}

class _CustomerRequestBottomSheetState
    extends ConsumerState<CustomerRequestBottomSheet> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = ref.watch(appColorsProvider);
    final requestState = ref.watch(requestFormProvider);
    final requestNotifier = ref.read(requestFormProvider.notifier);

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: appColors.seconderyBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                    isSelected:
                        requestState.requestType == RequestType.schedule,
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
              AppButton(
                bgcolor: appColors.primary,
                height: 54,
                width: double.infinity,
                text: 'Continue Request',
                onPressed: () {
                  context.push(AppRoutes.customerRequestDetails);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
