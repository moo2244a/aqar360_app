import 'package:aqar360/app/features/login/presentation/widgets/custom_auth_text_field.dart';
import 'package:flutter/material.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController? controller;

  const PasswordInputField({super.key, this.controller});

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return CustomAuthTextField(
      label: 'كلمة السر',
      hint: '••••••••',
      prefixIcon: Icons.lock_outline,
      obscureText: _isObscured,
      controller: widget.controller,
      suffixWidget: GestureDetector(
        onTap: () {
          setState(() {
            _isObscured = !_isObscured;
          });
        },
        child: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            _isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: 18,
          ),
        ),
      ),
    );
  }
}
