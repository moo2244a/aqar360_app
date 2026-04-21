import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/login/presentation/pages/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterNowTextComponent extends StatelessWidget {
  const RegisterNowTextComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: AppStrings.alreadyHaveAccountPrompt,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: Colors.black87),
        children: [
          TextSpan(
            text: AppStrings.registerNowLink,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: const Color(0xFF2E61B9)),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
          ),
        ],
      ),
    );
  }
}
