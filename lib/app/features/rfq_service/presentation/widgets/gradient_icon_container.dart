import 'package:flutter/material.dart';

class GradientIconContainer extends StatelessWidget {
  final IconData icon;
  final double size;
  final double iconSize;

  final BorderRadius borderRadius;

  const GradientIconContainer({
    super.key,
    this.icon = Icons.description_outlined,
    this.size = 56,
    this.iconSize = 28,

    this.borderRadius = const BorderRadius.all(Radius.circular(18)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2EC4B6).withValues(alpha: .15),
            const Color(0xFF3A86FF).withValues(alpha: .08),
          ],
        ),
      ),
      child: Icon(icon, color: Color(0xFF2EC4B6), size: iconSize),
    );
  }
}
