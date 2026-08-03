import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class TripDetailsCard extends StatelessWidget {
  final String pickupLocation;
  final String destination;
  final AppColors appColors;

  const TripDetailsCard({
    super.key,
    required this.pickupLocation,
    required this.destination,
    required this.appColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: appColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trip Details',
            style: GoogleFonts.poppins(
              color: appColors.secondaryText,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.my_location,
                color: appColors.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  pickupLocation.isNotEmpty ? pickupLocation : 'Pickup Location',
                  style: GoogleFonts.poppins(
                    color: appColors.text,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              width: 2,
              height: 16,
              color: appColors.border,
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.redAccent,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  destination.isNotEmpty ? destination : 'Destination Location',
                  style: GoogleFonts.poppins(
                    color: appColors.text,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
