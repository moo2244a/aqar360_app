import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTopBrandBar extends StatelessWidget {
  CustomTopBrandBar({super.key, TextStyle? textStyle, this.fontSize})
    : textStyle =
          textStyle ??
          AppTextStyles.headlineSmall.copyWith(color: AppColors.white);

  final TextStyle textStyle;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: FittedBox(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 5,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  color: AppColors.white.withValues(alpha: 0.05),
                ),
                child: Center(
                  child: Text(AppStrings.appName, style: textStyle),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
