import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_companion_app/app/shared/request/provider/request_form_provider.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/app/shared/widgets/animated_gradient_border.dart';

class Summery extends ConsumerWidget {
  const Summery({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appcolors = ref.watch(appColorsProvider);
    final requestState = ref.watch(requestFormProvider);

    return AnimatedGradientBorder(
      borderWidth: 2.0,

      borderRadius: BorderRadius.circular(30),
      backgroundColor: appcolors.background,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      gradient: SweepGradient(
        colors: [appcolors.border, appcolors.animatedBorder, appcolors.border],
        stops: const [0.0, 0.2, 0.5],
      ),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
      ],
      child: SizedBox(
        width:
            250 -
            40 -
            4, // 250 total width minus padding (20*2) and border (2*2)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, color: Colors.blue, size: 14),
                Text(
                  requestState.pickupLocation,
                  style: TextStyle(
                    fontSize: 12,
                    color: appcolors.secondaryText,
                  ),
                ),
              ],
            ),
            Text(
              requestState.destination,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
