import 'package:aqar360/app/features/onboarding/presentation/widgets/custom_app_logo.dart';
import 'package:flutter/material.dart';

class AuthHeaderBackground extends StatelessWidget {
  const AuthHeaderBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size.height * 0.25,
          width: size.width * 0.65,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 146, 133, 244),
                Color(0xFF4A90E2),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(size.width * 0.32),
              bottomRight: Radius.circular(size.width * 0.32),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              const CustomAppLogo(height: 80, width: 80),
            ],
          ),
        ),
      ],
    );
  }
}
