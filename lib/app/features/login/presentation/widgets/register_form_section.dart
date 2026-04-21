import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/core/usecases/snak_bar_message.dart';
import 'package:aqar360/app/features/login/presentation/pages/verify_email_page.dart';

import 'package:aqar360/app/features/login/presentation/widgets/curved_auth_portal.dart';
import 'package:aqar360/app/features/login/presentation/widgets/email_input_field.dart';
import 'package:aqar360/app/features/login/presentation/widgets/password_input_field.dart';
import 'package:aqar360/app/features/login/presentation/widgets/primary_auth_button.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/custom_top_brand_bar.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';
import 'package:aqar360/app/features/login/presentation/cubit/logic_in_register.dart/register_cubit.dart';
import 'package:aqar360/app/features/login/presentation/cubit/logic_in_register.dart/register_state.dart';
import 'package:aqar360/app/features/login/presentation/widgets/name_input_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterFormSection extends StatefulWidget {
  const RegisterFormSection({super.key, required this.onTap});
  final void Function() onTap;

  @override
  State<RegisterFormSection> createState() => _RegisterFormSectionState();
}

class _RegisterFormSectionState extends State<RegisterFormSection> {
  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey();
  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
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
              mainAxisSize: .min,
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
                  AppStrings.createNewAccount,
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge?.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 30),
                NameInputField(controller: nameController),
                const SizedBox(height: 10),
                EmailInputField(controller: emailController),
                const SizedBox(height: 10),
                PasswordInputField(controller: passwordController),

                const SizedBox(height: 20),
                BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterError) {
                      return SnackBarMessage.call(
                        context,
                        state.message,
                        false,
                      );
                    } else if (state is RegisterSuccess) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return VerifyEmailPage();
                          },
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    bool isLoading = false;
                    if (state is RegisterLoading) {
                      isLoading = true;
                    }
                    return PrimaryAuthButton(
                      text: AppStrings.createNewAccount,
                      isLoading: isLoading,
                      onTap: () async {
                        final UserModel userModel = UserModel(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          name: nameController.text.trim(),
                        );
                        if (globalKey.currentState!.validate()) {
                          await RegisterCubit.get(
                            context,
                          ).createUserWithEmailAndPassword(userModel);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
