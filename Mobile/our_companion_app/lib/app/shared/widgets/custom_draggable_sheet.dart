import 'package:flutter/material.dart';

class CustomDraggableSheet extends StatelessWidget {
  final ScrollableWidgetBuilder builder;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final DraggableScrollableController? controller;
  final Color backgroundColor;
  final bool snap;
  final List<double>? snapSizes;

  const CustomDraggableSheet({
    super.key,
    required this.builder,
    this.initialChildSize = 0.6,
    this.minChildSize = 0.25,
    this.maxChildSize = 0.9,
    this.controller,
    required this.backgroundColor,
    this.snap = false,
    this.snapSizes,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: controller,
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      snap: snap,
      snapSizes: snapSizes,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: builder(context, scrollController),
        );
      },
    );
  }
}
