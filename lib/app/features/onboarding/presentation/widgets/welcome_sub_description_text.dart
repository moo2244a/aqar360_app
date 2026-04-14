import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class WelcomeSubDescriptionText extends StatelessWidget {
  const WelcomeSubDescriptionText({
    super.key,
    required this.subDescriptionText,
    this.colorText = Colors.white70,
  });
  final String subDescriptionText;
  final Color colorText;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Container(
          width: 5,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.buttonBlue,
            borderRadius: BorderRadius.circular(15),
          ),
        ),

        Flexible(
          child: FittedBox(
            child: Column(
              children: [
                Text(
                  subDescriptionText,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, color: colorText, height: 1.7),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
