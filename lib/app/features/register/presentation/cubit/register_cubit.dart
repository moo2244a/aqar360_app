import 'package:aqar360/app/features/register/domain/entities/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:aqar360/app/features/register/presentation/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);
  Future<void> createUserWithEmailAndPassword(UserModel user) async {
    emit(RegisterLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: user.password,
          );
      await userCredential.user!.updateDisplayName(user.name);
      emit(RegisterSuccess(userModel: userCredential));
      return;
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;

        case 'email-already-in-use':
          message = 'The account already exists for that email.';
          break;

        default:
          message = e.message ?? 'Something went wrong';
      }
      print(e);
      emit(RegisterError(message: message));

      return;
    } catch (e) {
      print(e);
      emit(RegisterError(message: '$e'));

      return;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
