import 'package:aqar360/app/features/login/presentation/pages/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAccountComponent extends StatelessWidget {
  const AlreadyHaveAccountComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "لديك حساب بالفعل؟ ",
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: Colors.black87),
        children: [
          TextSpan(
            text: "سجل الدخول",
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: const Color(0xFF2E61B9)),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
          ),
        ],
      ),
    );
  }
}
