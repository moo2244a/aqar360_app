import 'package:aqar360/app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

/// ويدجت صورة العقار الرئيسية في خلفية الشاشة
/// تمتد من ربع الشاشة على اليسار وحتى نهاية اليمين
class WelcomeHeroPropertyImage extends StatelessWidget {
  const WelcomeHeroPropertyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: MediaQuery.sizeOf(context).width / 4,
      right: 0,
      child: Center(
        child: Container(
          height: 580,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.imageOnboardingOneScreen),
              fit: BoxFit.fill,
            ),
          ),
          child: const SizedBox(),
        ),
      ),
    );
  }
}
//hp 