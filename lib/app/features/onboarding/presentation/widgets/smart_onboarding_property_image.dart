import 'package:aqar360/app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

/// صورة العقار الرئيسية في شاشة البحث الذكي
/// تُعرض في الخلفية أعلى الشاشة
class SmartOnboardingPropertyImage extends StatelessWidget {
  const SmartOnboardingPropertyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 55,
      left: 5,
      right: 5,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 450,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.imageOnboardingTwoScreen),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
