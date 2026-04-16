import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {}

final class LoginInitial extends LoginState {}

// ================== Login ==================

class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserCredential userModel;

  LoginSuccess({required this.userModel});
}

final class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});
}
