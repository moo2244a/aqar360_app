import 'package:aqar360/app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

/// طبقة الأشكال السائلة ثلاثية الأبعاد
/// تُعرض فوق صورة العقار كتأثير بصري
class SmartOnboardingFluidShapesOverlay extends StatelessWidget {
  const SmartOnboardingFluidShapesOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      left: -25,
      right: -25,
      child: Container(
        height: 500,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.fluid3DlikeShapes),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
