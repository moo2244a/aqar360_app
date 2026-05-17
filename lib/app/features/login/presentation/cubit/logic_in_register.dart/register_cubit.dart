import 'package:aqar360/app/core/errors/auth_exception.dart';
import 'package:aqar360/app/core/utils/firebase_helper.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';
import 'package:aqar360/app/features/login/domain/usecases/register_usecase.dart';
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:aqar360/app/features/login/presentation/cubit/logic_in_register.dart/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.registerUsecase) : super(RegisterInitial());
  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);
  final RegisterUsecase registerUsecase;
  Future<void> createUserWithEmailAndPassword(UserModel user) async {
    emit(RegisterLoading());
    try {
      final result = await registerUsecase(user);
      result.fold(
        (l) {
          emit(RegisterError(message: l.message));
        },
        (r) {
          emit(RegisterSuccess(userModel: user));
        },
      );
    } on AuthException catch (e) {
      emit(RegisterError(message: e.message));
    } catch (e) {
      emit(RegisterError(message: 'An unexpected error occurred.'));
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseHelper.signOut();
    } on AuthException catch (e) {
      emit(RegisterError(message: e.message));
    }
  }
}
