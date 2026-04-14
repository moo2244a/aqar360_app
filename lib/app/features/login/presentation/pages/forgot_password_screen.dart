import 'package:aqar360/app/features/login/presentation/widgets/forgot_password_form_section.dart';
import 'package:aqar360/app/features/login/presentation/widgets/curved_auth_portal.dart';
import 'package:aqar360/app/features/login/presentation/widgets/auth_header_background.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.82,
                child: Stack(
                  children: [
                    const AuthHeaderBackground(),
                    Positioned(
                      top: size.height * 0.18,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: CurvedAuthPortal(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.18,
                      right: 0,
                      left: 0,
                      child: Center(child: ForgotPasswordFormSection()),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
