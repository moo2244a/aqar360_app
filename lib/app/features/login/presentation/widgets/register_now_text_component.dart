import 'package:aqar360/app/features/register/presentation/pages/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterNowTextComponent extends StatelessWidget {
  const RegisterNowTextComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "ليس لديك حساب؟ ",
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: Colors.black87),
        children: [
          TextSpan(
            text: "سجل الآن",
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
