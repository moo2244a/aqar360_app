import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/features/login/presentation/pages/forgot_password_screen.dart';
import 'package:flutter/material.dart';

class LoginOptionsRow extends StatelessWidget {
  const LoginOptionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: Checkbox(
                value: true,
                onChanged: (val) {},
                side: const BorderSide(color: AppColors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                activeColor: const Color(0xFF4A90E2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'تذكرني',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.white),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
            );
          },
          child: Text(
            'هل نسيت كلمة السر؟',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
