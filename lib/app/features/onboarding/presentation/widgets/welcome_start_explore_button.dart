import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class WelcomeStartExploreButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const WelcomeStartExploreButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  SizedBox(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
        const SizedBox(),
      ],
    );
  }
}
