import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/app/shared/location/presentation/controllers/location_controller.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class CurrentLocation extends ConsumerWidget {
  const CurrentLocation({super.key});

  @override
  Widget build(BuildContext context ,WidgetRef ref) {
    final location = ref.watch(locationControllerProvider);
    final appColors = ref.watch(appColorsProvider);
    
    return Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.location_on, color: appColors.primary),
    const SizedBox(width: 4),

    location.when(
      data: (data) {
        return Flexible(
          child: Text(
            "${data.subLocality}, ${data.locality}",
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: appColors.secondaryText,
            ),
          ),
        );
      },

      loading: () {
        return Text(
          "Getting location...",
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: appColors.secondaryText,
          ),
        );
      },

      error: (error, stackTrace) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Location Required"),
        content: const Text(
          "Please turn on your device location to continue.",
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.openLocationSettings();
            },
            child: const Text("Turn On"),
          ),
        ],
      ),
    );
  });

  return Text(
    "Location unavailable",
    style: GoogleFonts.poppins(
      fontSize: 16,
      color: appColors.secondaryText,
    ),
  );
},
    ),
  ],
);
  }
}