import 'package:aqar360/app/core/usecases/auth_dependencies.dart';
import 'package:aqar360/app/features/login/presentation/widgets/curved_auth_portal.dart';
import 'package:aqar360/app/features/login/presentation/widgets/auth_header_background.dart';
import 'package:aqar360/app/features/login/presentation/cubit/logic_in_register.dart/register_cubit.dart';
import 'package:aqar360/app/features/login/presentation/widgets/already_have_account_component.dart';
import 'package:aqar360/app/features/login/presentation/widgets/register_form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocProvider<RegisterCubit>(
      create: (context) {
        final authDependencies = AuthDependencies.create();
        return RegisterCubit(authDependencies.registerUsecase);
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
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

                        child: Center(child: RegisterFormSection(onTap: () {})),
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
