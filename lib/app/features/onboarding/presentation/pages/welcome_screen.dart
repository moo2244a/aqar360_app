import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/features/onboarding/presentation/pages/smart_onboarding_screen.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/welcome_app_logo.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/welcome_background_glow.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/welcome_bottom_fade_overlay.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/welcome_foreground_content.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/welcome_hero_property_image.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.midnightBlue,
        body: SafeArea(
          child: Stack(
            children: [
              const WelcomeBackgroundGlow(),

              const WelcomeHeroPropertyImage(),

              const WelcomeAppLogo(),

              const WelcomeBottomFadeOverlay(),

              WelcomeForegroundContent(
                onStartExplore: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SmartOnboardingScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
