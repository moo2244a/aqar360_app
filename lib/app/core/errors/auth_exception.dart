import 'package:aqar360/app/core/constants/auth_error_type.dart';

class AuthException implements Exception {
  final String message;
  final AuthErrorType type;

  const AuthException._({required this.message, required this.type});

  factory AuthException.invalidCredentials() => const AuthException._(
    message: 'Invalid email or password.',
    type: AuthErrorType.invalidCredentials,
  );

  factory AuthException.emailAlreadyInUse() => const AuthException._(
    message: 'This email is already registered.',
    type: AuthErrorType.emailAlreadyInUse,
  );

  factory AuthException.weakPassword() => const AuthException._(
    message: 'Password is too weak.',
    type: AuthErrorType.weakPassword,
  );

  factory AuthException.networkError() => const AuthException._(
    message: 'Network error. Please check your connection.',
    type: AuthErrorType.network,
  );

  factory AuthException.tooManyRequests() => const AuthException._(
    message: 'Too many attempts. Please try again later.',
    type: AuthErrorType.tooManyRequests,
  );

  factory AuthException.unknown([String? details]) => AuthException._(
    message:
        'An unexpected error occurred.${details != null ? ' $details' : ''}',
    type: AuthErrorType.unknown,
  );

  @override
  String toString() => 'AuthException(type: $type, message: $message)';
}
