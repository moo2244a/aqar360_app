import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// ويدجت الـ Glow الضوئي في خلفية الشاشة (أعلى اليمين)
/// يضيف تأثير الإضاءة المنتشرة اللونية (بنفسجي + أزرق)
class WelcomeBackgroundGlow extends StatelessWidget {
  const WelcomeBackgroundGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        height: 300,
        width: 150,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.lightPurple.withValues(alpha: 0.5),
              blurRadius: 150,
              spreadRadius: 100,
            ),
            BoxShadow(
              color: AppColors.buttonBlue.withValues(alpha: 0.4),
              blurRadius: 200,
              spreadRadius: 50,
            ),
          ],
        ),
      ),
    );
  }
}
