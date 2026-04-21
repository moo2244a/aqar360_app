import 'package:aqar360/app/core/constants/app_assets.dart';
import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class VerifyEmailFormSection extends StatelessWidget {
  const VerifyEmailFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(AppAssets.emailRevealAnimation, repeat: true),
          ),
          const Text(
            AppStrings.verifyEmailInstructions,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
