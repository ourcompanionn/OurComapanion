import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/app/shared/widgets/app_button.dart';

class FixedBottomActionBar extends StatelessWidget {
  final AppColors appColors;
  final bool isScheduled;
  final DateTime? scheduleTime;
  final VoidCallback onSchedulePressed;
  final VoidCallback onCancelSchedule;
  final VoidCallback onChoosePressed;

  const FixedBottomActionBar({
    super.key,
    required this.appColors,
    required this.isScheduled,
    this.scheduleTime,
    required this.onSchedulePressed,
    required this.onCancelSchedule,
    required this.onChoosePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: appColors.seconderyBackground,
        border: Border(top: BorderSide(color: appColors.border)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isScheduled && scheduleTime != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time_filled,
                    color: appColors.primary,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Scheduled for: ${scheduleTime!.day}/${scheduleTime!.month}/${scheduleTime!.year} at ${scheduleTime!.hour}:${scheduleTime!.minute.toString().padLeft(2, '0')}',
                    style: GoogleFonts.poppins(
                      color: appColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onCancelSchedule,
                    child: Icon(
                      Icons.cancel,
                      color: appColors.secondaryText,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              InkWell(
                onTap: onSchedulePressed,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isScheduled
                        ? appColors.primary.withValues(alpha: 0.1)
                        : appColors.border,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    color: isScheduled ? appColors.primary : appColors.text,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  bgcolor: appColors.primary,
                  height: 50,
                  width: double.infinity,
                  text: 'Choose',
                  onPressed: onChoosePressed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
