import 'package:aqar360/app/features/login/presentation/widgets/custom_auth_text_field.dart';
import 'package:flutter/material.dart';

class NameInputField extends StatelessWidget {
  final TextEditingController? controller;

  const NameInputField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomAuthTextField(
      controller: controller,
      keyboardType: TextInputType.name,
      label: 'الاسم',
      hint: 'أدخل اسمك بالكامل',
      prefixIcon: Icons.person_outline,
    );
  }
}
