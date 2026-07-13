import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/app/customer/service_page/data/models/service_item.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/app/shared/request/provider/request_form_provider.dart';
import 'package:our_companion_app/app/shared/request/presentation/controller/request_flow_controller.dart';
import 'package:our_companion_app/app/shared/request/presentation/widgets/vehicle_option.dart';

class InitialForm extends StatelessWidget {
  final AppColors appColors;
  final RequestFormState requestState;
  final RequestFormNotifier requestNotifier;
  final ScrollController scrollController;
  final RequestFlowController flowNotifier;
  final ServiceItem? itemIcon;

  const InitialForm({
    super.key,
    required this.appColors,
    required this.requestState,
    required this.requestNotifier,
    required this.scrollController,
    required this.flowNotifier,
    this.itemIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bottom sheet drag handle (visual only)
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Service Details Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: appColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: appColors.border),
                boxShadow: [
                  BoxShadow(
                    color: appColors.background.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected Service',
                    style: GoogleFonts.poppins(
                      color: appColors.text.withValues(alpha: 0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: appColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          requestState.selectedServiceIcon ?? Icons.design_services,
                          color: appColors.primary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          requestState.selectedService.isNotEmpty 
                              ? requestState.selectedService 
                              : 'Selected Service',
                          style: GoogleFonts.poppins(
                            color: appColors.text,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(Icons.check_circle, color: appColors.primary),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            if (requestState.requestType == RequestType.schedule) ...[
              Text(
                'Schedule Time',
                style: GoogleFonts.poppins(
                  color: appColors.text,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                  );
                  if (date != null) {
                    if (context.mounted) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
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
                      }
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: appColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: appColors.border),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: appColors.primary),
                      const SizedBox(width: 12),
                      Text(
                        requestState.scheduleTime != null
                            ? '${requestState.scheduleTime!.day}/${requestState.scheduleTime!.month}/${requestState.scheduleTime!.year} ${requestState.scheduleTime!.hour}:${requestState.scheduleTime!.minute.toString().padLeft(2, '0')}'
                            : 'Select Time',
                        style: GoogleFonts.poppins(color: appColors.text),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            Text(
              'Vehicle Preference',
              style: GoogleFonts.poppins(
                color: appColors.text,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: VehicleOption(
                    label: 'Without Vehicle',
                    icon: Icons.person,
                    appColors: appColors,
                    isSelected: !requestState.withVehicle,
                    onTap: () => requestNotifier.setWithVehicle(false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: VehicleOption(
                    label: 'With Vehicle',
                    icon: Icons.directions_car,
                    appColors: appColors,
                    isSelected: requestState.withVehicle,
                    onTap: () => requestNotifier.setWithVehicle(true),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  // Trigger dummy backend flow
                  flowNotifier.confirmRequest();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Confirm Request',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
