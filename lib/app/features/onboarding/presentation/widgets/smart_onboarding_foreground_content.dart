import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/onboarding/presentation/pages/auth_selection_screen.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/head_line_text_widget.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/smart_onboarding_next_button.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/welcome_sub_description_text.dart';
import 'package:flutter/material.dart';

/// المحتوى الأمامي لشاشة البحث الذكي
/// يحتوي على العنوان الرئيسي والوصف وزر التالي
class SmartOnboardingForegroundContent extends StatelessWidget {
  const SmartOnboardingForegroundContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          const HeadlineTextWidget(
            title1: AppStrings.smartOnboardingHeadlinePart1,
            title2: AppStrings.smartOnboardingHeadlinePart2,
            colorT1: AppColors.black,
          ),
          const SizedBox(height: 24),
          const WelcomeSubDescriptionText(
            colorText: AppColors.black,
            subDescriptionText: AppStrings.smartOnboardingSubDescription,
          ),
          const SizedBox(height: 15),
          SmartOnboardingNextButton(
            iconData: Icons.arrow_forward_ios,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthSelectionScreen()),
              );
            },
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
