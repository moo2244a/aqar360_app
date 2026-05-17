import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? suffixColor;
  final Color? labelColor;

  final Widget? suffixWidget;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;
  const CustomTextField({
    super.key,
    this.label,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixColor,
    this.suffixWidget,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.labelColor,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Text(
                label!,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: labelColor ?? AppColors.white,
                ),
              )
            : SizedBox(),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          maxLength: maxLength,
          onChanged: onChanged,
          obscureText: obscureText,
          maxLines: maxLines,

          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.midnightBlue),
          decoration: InputDecoration(
            hintText: hint,

            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  )
                : null,
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
              vertical: 16,
              horizontal: 16,
            ),
          ),
        ),
      ],
    );
  }
}
