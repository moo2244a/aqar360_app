import 'package:aqar360/app/features/login/data/models/user_model.dart';

abstract class LoginState {}

final class LoginInitial extends LoginState {}

// ================== Login ==================

class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserModel userModel;

  LoginSuccess({required this.userModel});
}

final class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});
}
