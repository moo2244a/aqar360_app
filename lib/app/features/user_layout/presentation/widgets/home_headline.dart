import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/head_line_text_widget.dart';
import 'package:flutter/material.dart';

class HomeHeadline extends StatelessWidget {
  const HomeHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          height: 70,
          child: FittedBox(
            child: HeadlineTextWidget(
              title1: AppStrings.exploreRealEstate,
              title2: AppStrings.tenthOfRamadan,
              fontSize: 30,
              colorT1: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
