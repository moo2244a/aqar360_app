import 'package:aqar360/app/features/login/presentation/cubit/login_state.dart';
import 'package:aqar360/app/features/register/domain/entities/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);
  Future<UserCredential?> signInWithEmailAndPassword(UserModel user) async {
    emit(LoginLoading());

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email,
        password: user.password ?? '',
      );

      emit(LoginSuccess(userModel: credential));
      return credential;
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided.';
          break;
        case 'invalid-email':
          message = 'Email format is invalid.';
          break;
        default:
          message = e.message ?? 'Login failed';
      }

      emit(LoginError(message: message));
      return null;
    } catch (e) {
      emit(LoginError(message: 'Something went wrong'));
      return null;
    }
  }
}
