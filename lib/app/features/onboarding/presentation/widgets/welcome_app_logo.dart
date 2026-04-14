import 'package:aqar360/app/features/onboarding/presentation/widgets/custom_app_logo.dart';
import 'package:flutter/material.dart';

/// ويدجت لوجو التطبيق الظاهر في أعلى الشاشة (يمين - وسط)
/// حجم ثابت 125×125
class WelcomeAppLogo extends StatelessWidget {
  const WelcomeAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 350,
      top: 0,
      right: 0,
      child: CustomAppLogo(height: 125, width: 125),
    );
  }
}
