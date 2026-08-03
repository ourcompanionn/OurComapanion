import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class AnimatedGradientBorder extends ConsumerStatefulWidget {
  final Widget child;
  final double borderWidth;
  final BorderRadius borderRadius;
  final Gradient? gradient;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? boxShadow;

  const AnimatedGradientBorder({
    super.key,
    required this.child,
    this.borderWidth = 2.0,
    this.borderRadius = BorderRadius.zero,
    this.gradient,
    this.backgroundColor,
    this.padding,
    this.boxShadow,
  });

  @override
  ConsumerState<AnimatedGradientBorder> createState() =>
      _AnimatedGradientBorderState();
}

class _AnimatedGradientBorderState extends ConsumerState<AnimatedGradientBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = ref.watch(appColorsProvider);
    final effectiveBackgroundColor =
        widget.backgroundColor ?? appColors.background;
    final effectiveGradient =
        widget.gradient ??
        SweepGradient(
          colors: [
            appColors.border,
            appColors.animatedBorder,
            appColors.border,
          ],
          stops: const [0.0, 0.5, 1.0],
        );

    return CustomPaint(
      painter: _GradientBorderPainter(
        animation: _controller,
        borderWidth: widget.borderWidth,
        borderRadius: widget.borderRadius,
        gradient: effectiveGradient,
      ),
      child: Container(
        padding: EdgeInsets.all(widget.borderWidth),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          boxShadow: widget.boxShadow,
        ),
        child: Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: widget.borderRadius.subtract(
              BorderRadius.circular(widget.borderWidth),
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  final Animation<double> animation;
  final double borderWidth;
  final BorderRadius borderRadius;
  final Gradient gradient;

  _GradientBorderPainter({
    required this.animation,
    required this.borderWidth,
    required this.borderRadius,
    required this.gradient,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Create a sweep gradient that rotates based on the animation value
    final paint = Paint()
      ..shader = SweepGradient(
        colors: gradient.colors,
        stops: gradient.stops,
        transform: GradientRotation(animation.value * 2 * math.pi),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    // Draw the rounded rectangle with the gradient border
    // We inset the rectangle by half the border width so it draws completely inside the bounds
    final innerRect = rect.deflate(borderWidth / 2);
    canvas.drawRRect(borderRadius.toRRect(innerRect), paint);
  }

  @override
  bool shouldRepaint(covariant _GradientBorderPainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.gradient != gradient;
  }
}
