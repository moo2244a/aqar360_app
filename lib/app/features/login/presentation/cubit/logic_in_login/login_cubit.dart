import 'package:aqar360/app/core/errors/auth_exception.dart';
import 'package:aqar360/app/core/utils/firebase_helper.dart';
import 'package:aqar360/app/features/login/domain/usecases/login_usecase.dart';
import 'package:aqar360/app/features/login/presentation/cubit/logic_in_login/login_state.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUsecase}) : super(LoginInitial());
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);
  final LoginUsecase loginUsecase;
  Future<void> signInWithEmailAndPassword(UserModel user) async {
    emit(LoginLoading());

    try {
      final userCredential = await FirebaseHelper.signInWithEmailAndPassword(
        user,
      );

      emit(LoginSuccess(userModel: userCredential));
    } on AuthException catch (e) {
      emit(LoginError(message: e.message));
    } catch (e) {
      emit(LoginError(message: 'Something went wrong'));
    }
  }
}
