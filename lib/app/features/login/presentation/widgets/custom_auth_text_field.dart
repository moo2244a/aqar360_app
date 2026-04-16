import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final Color? suffixColor;
  final Widget? suffixWidget;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomAuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.suffixIcon,
    this.suffixColor,
    this.suffixWidget,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          obscureText: obscureText,

          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.midnightBlue),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              prefixIcon,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            suffixIcon:
                suffixWidget ??
                (suffixIcon != null
                    ? Icon(
                        suffixIcon,
                        color:
                            suffixColor ??
                            Theme.of(context).colorScheme.primary,
                        size: 20,
                      )
                    : null),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
          ),
        ),
      ],
    );
  }
}
