import 'package:aqar360/app/features/login/presentation/widgets/curved_auth_portal.dart';
import 'package:aqar360/app/features/login/presentation/widgets/auth_header_background.dart';
import 'package:aqar360/app/features/onboarding/presentation/pages/welcome_screen.dart';
import 'package:aqar360/app/features/register/presentation/cubit/register_cubit.dart';
import 'package:aqar360/app/features/register/presentation/widgets/already_have_account_component.dart';
import 'package:aqar360/app/features/register/presentation/widgets/register_form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  late final AnimationController _doorController;
  late final Animation<double> _doorAngle;

  @override
  void initState() {
    super.initState();

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
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const WelcomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return ScaleTransition(scale: animation, child: child);
                },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _doorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
      child: Directionality(
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
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _doorAngle,
                            builder: (context, child) {
                              return Transform(
                                alignment: Alignment.centerLeft,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.0015) // perspective
                                  ..rotateY(
                                    _doorAngle.value * 3.14159265 / 180,
                                  ),
                                child: child,
                              );
                            },
                            child: RegisterFormSection(
                              onTap: () {
                                _doorController.forward();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),
                const AlreadyHaveAccountComponent(),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
