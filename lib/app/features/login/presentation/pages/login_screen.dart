import 'package:aqar360/app/core/usecases/auth_dependencies.dart';
import 'package:aqar360/app/features/login/presentation/cubit/logic_in_login/login_cubit.dart';
import 'package:aqar360/app/features/home/presentation/screens/home_screen.dart';
import 'package:aqar360/app/features/login/presentation/widgets/login_form_section.dart';
import 'package:aqar360/app/features/login/presentation/widgets/curved_auth_portal.dart';
import 'package:aqar360/app/features/login/presentation/widgets/register_now_text_component.dart';
import 'package:aqar360/app/features/login/presentation/widgets/auth_header_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
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
  void dispose() {
    _doorController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocProvider<LoginCubit>(
      create: (context) {
        final authDependencies = AuthDependencies.create();
        return LoginCubit(loginUsecase: authDependencies.loginUsecase);
      },

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
                                  ..setEntry(3, 2, 0.0015) // perspective
                                  ..rotateY(
                                    _doorAngle.value * 3.14159265 / 180,
                                  ),
                                child: child,
                              );
                            },
                            child: LoginFormSection(
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
                const RegisterNowTextComponent(),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
