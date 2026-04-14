import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryAuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const PrimaryAuthButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 20, 127, 249),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.displayLarge?.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
