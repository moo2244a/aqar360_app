import 'package:aqar360/app/features/onboarding/presentation/widgets/welcome_headline_title.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/welcome_start_explore_button.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/welcome_sub_description_text.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/custom_top_brand_bar.dart';
import 'package:flutter/material.dart';

class WelcomeForegroundContent extends StatelessWidget {
  final VoidCallback onStartExplore;

  const WelcomeForegroundContent({super.key, required this.onStartExplore});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        CustomTopBrandBar(),

        const Spacer(flex: 4),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              WelcomeHeadlineTitle(title1: 'ابحث عن', title2: 'الفخامة'),
              SizedBox(height: 24),
              WelcomeSubDescriptionText(
                subDescriptionText:
                    'اكتشف عالماً جديداً من العقارات\nالاستثنائية التى تتجاوز حدود الخيال',
              ),
            ],
          ),
        ),

        const Spacer(),

        WelcomeStartExploreButton(
          onPressed: onStartExplore,
          text: 'ابدأ الاستكشاف',
        ),

        const Spacer(),
      ],
    );
  }
}
