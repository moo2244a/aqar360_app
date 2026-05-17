import 'dart:ui';

import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int index;
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.title,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelect = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),

          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: isSelect
                      ? AppColors.buttonBlue
                      : Theme.of(context).colorScheme.surface,
                  blurRadius: 100,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedScale(
                  scale: isSelect ? 1.2 : 1.0,
                  duration: const Duration(milliseconds: 200),

                  child: Icon(
                    icon,
                    color: isSelect
                        ? Theme.of(context).colorScheme.primary
                        : AppColors.slateBlueGray,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: isSelect
                        ? Theme.of(context).colorScheme.primary
                        : AppColors.slateBlueGray,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
