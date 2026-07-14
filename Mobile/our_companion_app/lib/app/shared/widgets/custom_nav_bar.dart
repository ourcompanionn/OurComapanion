import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

class CustomNavBar extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  double _getTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = ref.watch(appColorsProvider);
    final List<NavBarItem> items = [
      NavBarItem(icon: Icons.home_rounded, label: 'Home'),
      NavBarItem(icon: Icons.grid_view_rounded, label: 'Services'),
      NavBarItem(icon: Icons.assignment_rounded, label: 'Activity'),
      NavBarItem(icon: Icons.person_rounded, label: 'Profile'),
    ];

    final TextStyle textStyle = TextStyle(
      color: appColors.secondary,
      fontWeight: FontWeight.bold,
      fontSize: 13,
      fontFamily: 'Poppins',
    );

    final List<double> itemWidths = List.generate(items.length, (index) {
      if (index == currentIndex) {
        final double labelWidth = _getTextWidth(items[index].label, textStyle);
        return 24.0 + 8.0 + labelWidth + 40.0;
      } else {
        return 24.0 + 40.0;
      }
    });

    return Container(
      margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: appColors.border, width: 2),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double totalWidth = constraints.maxWidth;
          final double sumWidths = itemWidths.reduce((a, b) => a + b);
          final double freeSpace = totalWidth - sumWidths;
          final double space = freeSpace / items.length;
          final double halfSpace = space / 2;

          // Calculate left position for each item
          final List<double> itemLefts = [];
          double currentLeft = halfSpace;
          for (int i = 0; i < items.length; i++) {
            itemLefts.add(currentLeft);
            currentLeft += itemWidths[i] + space;
          }

          return Stack(
            children: [
              // AnimatedPositioned(
              //   duration: const Duration(milliseconds: 250),
              //   curve: Curves.easeOutCubic,
              //   left: itemLefts[currentIndex],
              //   width: itemWidths[currentIndex],
              //   top: 0,
              //   bottom: 0,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: appColors.secondary.withValues(alpha: 0.15),
              //       borderRadius: BorderRadius.circular(24),
              //     ),
              //   ),
              // ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                left: itemLefts[currentIndex],
                width: itemWidths[currentIndex],
                top: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      decoration: BoxDecoration(
                        color: appColors.secondary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(items.length, (index) {
                  final isSelected = currentIndex == index;
                  final item = items[index];

                  return GestureDetector(
                    onTap: () => onTap(index),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      width: itemWidths[index],
                      height:
                          52, // matches original vertical padding 14 + icon 24 + 14
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item.icon,
                            color: isSelected ? appColors.accent : Colors.grey,
                            size: 24,
                          ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutCubic,
                            child: isSelected
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(width: 8),
                                      Text(item.label, style: textStyle),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}

class NavBarItem {
  final IconData icon;
  final String label;

  NavBarItem({required this.icon, required this.label});
}
