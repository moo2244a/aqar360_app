import 'package:aqar360/app/core/constants/app_assets.dart';
import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/constants/app_text_styles.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/custom_top_brand_bar.dart';
import 'package:flutter/material.dart';

class AuthSelectionImageHeader extends StatelessWidget {
  const AuthSelectionImageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.sizeOf(context).height / 2.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  MediaQuery.sizeOf(context).width / 3,
                ),
                bottomRight: Radius.circular(
                  MediaQuery.sizeOf(context).width / 3,
                ),
              ),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppAssets.authSelection),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 80),
                CustomTopBrandBar(
                  textStyle: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.white,
                  ),
                ),
                Spacer(),
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: AppColors.buttonBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      AppAssets.brandLogo,
                      width: 30,
                      height: 30,
                      fit: BoxFit.fill,
                      color: AppColors.backgroundWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
