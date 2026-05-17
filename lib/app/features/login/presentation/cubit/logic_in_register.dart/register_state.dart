import 'package:aqar360/app/features/login/data/models/user_model.dart';

abstract class RegisterState {
  const RegisterState();
}

// ================== Initial ==================
class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

// ================== Register ==================

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterState {
  final UserModel userModel;

  const RegisterSuccess({required this.userModel});
}

class RegisterError extends RegisterState {
  final String message;

  const RegisterError({required this.message});
}
