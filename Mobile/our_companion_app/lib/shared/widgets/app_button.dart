import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class AppButton extends ConsumerWidget {
  final double width;
  final double height;
  final Color bgcolor;
  final String text;
  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    required this.bgcolor,
    required this.height,
    required this.width,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: appColors.surface),
        ),
      ),
    );
  }
}
