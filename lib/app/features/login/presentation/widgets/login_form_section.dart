import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/usecases/snak_bar_message.dart';
import 'package:aqar360/app/features/login/presentation/cubit/login_cubit.dart';
import 'package:aqar360/app/features/login/presentation/cubit/login_state.dart';
import 'package:aqar360/app/features/login/presentation/pages/home_screen.dart';
import 'package:aqar360/app/features/login/presentation/widgets/curved_auth_portal.dart';
import 'package:aqar360/app/features/login/presentation/widgets/email_input_field.dart';
import 'package:aqar360/app/features/login/presentation/widgets/login_options_row.dart';
import 'package:aqar360/app/features/login/presentation/widgets/password_input_field.dart';
import 'package:aqar360/app/features/login/presentation/widgets/primary_auth_button.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/custom_top_brand_bar.dart';
import 'package:aqar360/app/features/register/domain/entities/user_model.dart';
import 'package:aqar360/app/features/register/presentation/pages/verify_email_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormSection extends StatelessWidget {
  LoginFormSection({super.key, required this.onTap});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();

  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: CurvedAuthPortal(
        color: const Color(0xff4682d7),
        margin: 15,
        gradient: const LinearGradient(
          colors: [Color(0xFF6AA9FF), Color(0xFF3D6BFF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              CustomTopBrandBar(
                textStyle: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'تسجيل الدخول',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 25),
              const EmailInputField(),
              const SizedBox(height: 18),
              const PasswordInputField(),
              const SizedBox(height: 12),
              const LoginOptionsRow(),
              const SizedBox(height: 60),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginError) {
                    return SnackBarMessage.call(context, state.message, false);
                  } else if (state is LoginSuccess) {
                    if (state.userModel.user!.emailVerified) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                      return SnackBarMessage.call(
                        context,
                        "تم تسجيل الدخول بنجاح ",
                        true,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return VerifyEmailPage();
                          },
                        ),
                      );
                    }
                  }
                },
                builder: (context, state) {
                  bool isLoading = false;
                  if (state is LoginLoading) {
                    isLoading = true;
                  }
                  return PrimaryAuthButton(
                    text: "سجل الدخول",
                    isLoading: isLoading,
                    onTap: () async {
                      final UserModel userModel = UserModel(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      if (globalKey.currentState!.validate()) {
                        await LoginCubit.get(
                          context,
                        ).signInWithEmailAndPassword(userModel);
                      }

                      // onTap();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
