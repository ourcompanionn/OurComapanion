import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class AcceptedView extends StatelessWidget {
  final AppColors appColors;
  final ScrollController scrollController;

  const AcceptedView({
    super.key,
    required this.appColors,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
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
            Text(
              'Request Accepted!',
              style: GoogleFonts.poppins(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: appColors.primary.withValues(alpha: 0.2),
                child: Icon(Icons.person, color: appColors.primary),
              ),
              title: Text(
                'John Doe',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: appColors.text,
                ),
              ),
              subtitle: Text(
                '4.9 ★ • 2 mins away',
                style: GoogleFonts.poppins(color: appColors.secondaryText),
              ),
              trailing: IconButton(
                icon: Icon(Icons.phone, color: appColors.primary),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'View Details',
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
