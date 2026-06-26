import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/shared/widgets/app_text_field.dart';

class CustomerSearchLocation extends ConsumerStatefulWidget {
  const CustomerSearchLocation({super.key});

  @override
  ConsumerState<CustomerSearchLocation> createState() =>
      _CustomerSearchLocationState();
}

class _CustomerSearchLocationState
    extends ConsumerState<CustomerSearchLocation> {
  bool _isSearchExpanded = false;
  @override
  Widget build(BuildContext context) {
    final appColors = ref.watch(appColorsProvider);
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Container(
        padding: EdgeInsets.all(_isSearchExpanded ? 16 : 0),
        decoration: BoxDecoration(
          border: Border.all(color: appColors.border),
          color: _isSearchExpanded ? appColors.background : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isSearchExpanded
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_isSearchExpanded)
              AppTextField(
                controller: TextEditingController(),
                hintText: 'Search for services...',
                prefixIcon: Icons.search,
                readOnly: true,

                onTap: () {
                  setState(() {
                    _isSearchExpanded = true;
                  });
                },
              ),
            if (_isSearchExpanded) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Set Location",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: appColors.text,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _isSearchExpanded = false;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              AppTextField(
                controller: TextEditingController(),
                hintText: "Pickup Location (Where from?)",
                prefixIcon: Icons.my_location,
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: TextEditingController(),
                hintText: "Destination (Where to?)",
                prefixIcon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    setState(() {
                      _isSearchExpanded = false;
                    });
                  },
                  child: Text(
                    "Confirm Location",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
