import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/core/usecases/snak_bar_message.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';
import 'package:aqar360/app/features/login/presentation/cubit/logic_in_login/login_cubit.dart';
import 'package:aqar360/app/features/login/presentation/cubit/logic_in_login/login_state.dart';
import 'package:aqar360/app/features/login/presentation/pages/verify_email_page.dart';
import 'package:aqar360/app/features/login/presentation/widgets/curved_auth_portal.dart';
import 'package:aqar360/app/features/login/presentation/widgets/email_input_field.dart';
import 'package:aqar360/app/features/login/presentation/widgets/login_options_row.dart';
import 'package:aqar360/app/features/login/presentation/widgets/password_input_field.dart';
import 'package:aqar360/app/features/login/presentation/widgets/primary_auth_button.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/custom_top_brand_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key, required this.onTap});
  final void Function() onTap;

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey();
  @override
  void dispose() {
    emailController.dispose();

    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.64,
        child: CurvedAuthPortal(
          color: const Color(0xff4682d7),
          margin: 15,
          gradient: const LinearGradient(
            colors: [Color(0xFF6AA9FF), Color(0xFF3D6BFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          child: SingleChildScrollView(
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
                  AppStrings.loginFormTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge?.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 25),
                EmailInputField(controller: emailController),
                const SizedBox(height: 18),
                PasswordInputField(controller: passwordController),
                const SizedBox(height: 12),
                const LoginOptionsRow(),
                const SizedBox(height: 30),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginError) {
                      return SnackBarMessage.call(
                        context,
                        state.message,
                        false,
                      );
                    } else if (state is LoginSuccess) {
                      if (state.userModel.emailVerified!) {
                        if (!state.userModel.isBlock!) {
                          widget.onTap();

                          return SnackBarMessage.call(
                            context,
                            AppStrings.loginSuccessMessage,
                            true,
                          );
                        } else if (state.userModel.isBlock!) {
                          return SnackBarMessage.call(
                            context,
                            AppStrings.accountBlocked,
                            false,
                          );
                        }
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return VerifyEmailPage(
                                userModel: state.userModel,
                              );
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
                      text: AppStrings.signInButton,
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
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
