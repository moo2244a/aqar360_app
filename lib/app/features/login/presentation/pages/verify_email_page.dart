import 'dart:async';

import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/core/usecases/snak_bar_message.dart';
import 'package:aqar360/app/features/home/presentation/screens/home_screen.dart';
import 'package:aqar360/app/features/login/presentation/widgets/auth_header_background.dart';
import 'package:aqar360/app/features/login/presentation/widgets/curved_auth_portal.dart';
import 'package:aqar360/app/features/login/presentation/widgets/verify_email_form_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage>
    with TickerProviderStateMixin {
  bool isLoading = false;
  bool isVerified = false;
  late Timer timer;
  late final AnimationController _doorController;
  late final Animation<double> _doorAngle;

  @override
  void initState() {
    super.initState();
    resendEmail();
    timer = Timer.periodic(Duration(seconds: 2), (_) {
      checkEmailVerified();
    });
    initAnimation();
  }

  void initAnimation() {
    _doorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _doorAngle = Tween<double>(begin: 0.0, end: -65.0).animate(
      CurvedAnimation(parent: _doorController, curve: Curves.easeInOut),
    );
    _doorController.addListener(() {
      setState(() {});
    });
    _doorController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return ScaleTransition(scale: animation, child: child);
                },
            transitionDuration: const Duration(milliseconds: 500),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  dispose() {
    _doorController.dispose();
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isVerified) {
      _doorController.forward();
      timer.cancel();
    }
  }

  Future<void> resendEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      SnackBarMessage.call(
        context,
        AppStrings.verifyEmailSentConfirmation,
        true,
      );
    } catch (e) {
      SnackBarMessage.call(context, AppStrings.genericSendError, false);
    }
  }

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
                          height: MediaQuery.sizeOf(context).height * 0.64,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.18,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _doorAngle,
                          builder: (context, child) {
                            return Transform(
                              alignment: Alignment.centerLeft,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.0015)
                                ..rotateY(_doorAngle.value * 3.14159265 / 180),
                              child: child,
                            );
                          },
                          child: CurvedAuthPortal(
                            height: MediaQuery.sizeOf(context).height * 0.64,
                            color: const Color(0xff4682d7),
                            margin: 15,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6AA9FF), Color(0xFF3D6BFF)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            child: VerifyEmailFormSection(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
