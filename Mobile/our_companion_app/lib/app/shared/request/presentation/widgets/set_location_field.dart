import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/app/shared/request/presentation/controller/location_field_controller.dart';

class SetLocationField extends ConsumerWidget {
  const SetLocationField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    final locationController = ref.watch(locationFieldControllerProvider);
    final isAddStopDisabled = locationController.stopControllers.length >= 3;

    return Container(
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: appColors.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Column(
            children: [
              Icon(Icons.trip_origin, size: 16, color: appColors.secondaryText),
              Container(
                height: 34,
                width: 2,
                color: appColors.secondaryText.withValues(alpha: 0.5),
              ),
              ...List.generate(locationController.stopControllers.length, (
                index,
              ) {
                return Column(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: appColors.secondaryText,
                    ),
                    Container(
                      height: 38,
                      width: 2,
                      color: appColors.secondaryText.withValues(alpha: 0.5),
                    ),
                  ],
                );
              }),
              Icon(Icons.square, size: 16, color: appColors.primary),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                TextField(
                  controller: locationController.pickupController,
                  onChanged: locationController.setPickup,
                  decoration: InputDecoration(
                    hintText: 'Enter pickup location',
                    hintStyle: GoogleFonts.poppins(
                      color: appColors.secondaryText,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  style: GoogleFonts.poppins(color: appColors.text),
                ),
                Divider(height: 1, color: appColors.border),
                ...List.generate(locationController.stopControllers.length, (
                  index,
                ) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller:
                                  locationController.stopControllers[index],
                              onChanged: (value) =>
                                  locationController.updateStop(index, value),
                              decoration: InputDecoration(
                                hintText: 'Enter stop location',
                                hintStyle: GoogleFonts.poppins(
                                  color: appColors.secondaryText,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              style: GoogleFonts.poppins(color: appColors.text),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, size: 20),
                            onPressed: () =>
                                locationController.removeStop(index),
                          ),
                        ],
                      ),
                      Divider(height: 1, color: appColors.border),
                    ],
                  );
                }),
                TextField(
                  controller: locationController.destinationController,
                  onChanged: locationController.setDestination,
                  decoration: InputDecoration(
                    hintText: 'Where to?',
                    hintStyle: GoogleFonts.poppins(
                      color: appColors.secondaryText,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  style: GoogleFonts.poppins(color: appColors.text),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appColors.background,
              border: Border.all(
                color: isAddStopDisabled 
                    ? appColors.border.withValues(alpha: 0.3) 
                    : appColors.border
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.add, 
                color: isAddStopDisabled 
                    ? appColors.secondaryText.withValues(alpha: 0.5) 
                    : appColors.text, 
                size: 20
              ),
              onPressed: isAddStopDisabled ? null : locationController.addStop,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
