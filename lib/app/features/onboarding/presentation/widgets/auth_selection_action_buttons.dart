import 'package:aqar360/app/features/login/presentation/pages/login_screen.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/welcome_start_explore_button.dart';
import 'package:aqar360/app/features/register/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';

class AuthSelectionActionButtons extends StatelessWidget {
  const AuthSelectionActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        WelcomeStartExploreButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          text: "تسجيل دخول",
        ),
        WelcomeStartExploreButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
          text: "انشاء حساب جديد",
        ),
      ],
    );
  }
}
