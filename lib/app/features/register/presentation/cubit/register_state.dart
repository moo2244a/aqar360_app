import 'package:firebase_auth/firebase_auth.dart';

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
  final UserCredential userModel;

  const RegisterSuccess({required this.userModel});
}

class RegisterError extends RegisterState {
  final String message;

  const RegisterError({required this.message});
}
