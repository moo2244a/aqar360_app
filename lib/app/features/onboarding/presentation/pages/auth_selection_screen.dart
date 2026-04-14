import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/auth_selection_action_buttons.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/auth_selection_image_header.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/head_line_text_widget.dart';
import 'package:flutter/material.dart';

class AuthSelectionScreen extends StatelessWidget {
  const AuthSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: const [
              AuthSelectionImageHeader(),
              SizedBox(height: 10),
              HeadlineTextWidget(
                colorT1: AppColors.black,
                title1: "ابدا رحلتك الان",
                title2: "في العاشر من رمضان",
                fontSize: 45,
              ),
              SizedBox(height: 40),
              AuthSelectionActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
