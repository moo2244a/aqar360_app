import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/features/login/presentation/widgets/curved_auth_portal.dart';
import 'package:aqar360/app/features/login/presentation/widgets/email_input_field.dart';
import 'package:aqar360/app/features/login/presentation/widgets/primary_auth_button.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/custom_top_brand_bar.dart';
import 'package:flutter/material.dart';

class ForgotPasswordFormSection extends StatelessWidget {
  const ForgotPasswordFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedAuthPortal(
      color: const Color(0xff4682d7),
      margin: 15,
      gradient: const LinearGradient(
        colors: [Color(0xFF6AA9FF), Color(0xFF3D6BFF)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            CustomTopBrandBar(
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 8),
            Text(
              'استعادة كلمة السر',
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 15),
            Text(
              'أدخل بريدك الإلكتروني وسيتم إرسال رابط لاستعادة كلمة السر الخاص بك.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.white.withOpacity(0.8),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 25),
            const EmailInputField(),
            const SizedBox(height: 40),
            PrimaryAuthButton(text: 'إرسال الرابط', onTap: () {}),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'العودة لتسجيل الدخول',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.white,
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
