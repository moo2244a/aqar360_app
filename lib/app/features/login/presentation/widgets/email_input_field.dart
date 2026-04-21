import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/core/utils/app_validators.dart';
import 'package:aqar360/app/features/login/presentation/widgets/custom_auth_text_field.dart';
import 'package:flutter/material.dart';

class EmailInputField extends StatelessWidget {
  final TextEditingController? controller;

  const EmailInputField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomAuthTextField(
      controller: controller,
      validator: AppValidators.email,
      keyboardType: TextInputType.emailAddress,
      label: AppStrings.emailFieldLabel,
      hint: AppStrings.emailFieldHint,
      prefixIcon: Icons.email_outlined,
    );
  }
}
