import 'package:aqar360/app/features/onboarding/presentation/widgets/smart_onboarding_fluid_shapes_overlay.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/smart_onboarding_foreground_content.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/smart_onboarding_property_image.dart';
import 'package:flutter/material.dart';

class SmartOnboardingScreen extends StatelessWidget {
  const SmartOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              const SmartOnboardingPropertyImage(),
              const SmartOnboardingFluidShapesOverlay(),
              const SmartOnboardingForegroundContent(),
            ],
          ),
        ),
      ),
    );
  }
}
