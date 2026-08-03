import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentLocationMarker extends ConsumerStatefulWidget {
  const CurrentLocationMarker({super.key});

  @override
  ConsumerState<CurrentLocationMarker> createState() =>
      _CurrentLocationMarkerState();
}

class _CurrentLocationMarkerState
    extends ConsumerState<CurrentLocationMarker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();

    _scale = Tween<double>(
      begin: 1,
      end: 2,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _opacity = Tween<double>(
      begin: .75,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return Transform.scale(
                scale: _scale.value,
                child: Opacity(
                  opacity: _opacity.value,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 21, 94, 189),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          ),

          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black.withOpacity(.15),
                ),
              ],
            ),
          ),

          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Color(0xff1A73E8),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}