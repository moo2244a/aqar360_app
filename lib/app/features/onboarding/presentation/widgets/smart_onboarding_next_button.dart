import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// زر التالي الدائري في شاشة البحث الذكي
/// يستخدم للانتقال للشاشة التالية
class SmartOnboardingNextButton extends StatelessWidget {
  const SmartOnboardingNextButton({
    super.key,
    required this.iconData,
    this.onPressed,
  });
  final IconData iconData;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        padding: const EdgeInsets.all(20),
        style: IconButton.styleFrom(
          backgroundColor: AppColors.buttonBlue,
          foregroundColor: AppColors.white,
        ),
        onPressed: onPressed,
        icon: Icon(iconData),
      ),
    );
  }
}
