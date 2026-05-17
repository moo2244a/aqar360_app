import 'package:aqar360/app/core/constants/auth_error_type.dart';

class AuthException implements Exception {
  final String message;
  final AuthErrorType type;

  const AuthException._({required this.message, required this.type});

  factory AuthException.invalidCredentials() => const AuthException._(
    message: 'البريد الإلكتروني أو كلمة المرور غير صحيحة.',
    type: AuthErrorType.invalidCredentials,
  );

  factory AuthException.emailAlreadyInUse() => const AuthException._(
    message: 'هذا البريد الإلكتروني مستخدم بالفعل.',
    type: AuthErrorType.emailAlreadyInUse,
  );

  factory AuthException.weakPassword() => const AuthException._(
    message: 'كلمة المرور ضعيفة جدًا.',
    type: AuthErrorType.weakPassword,
  );

  factory AuthException.networkError() => const AuthException._(
    message: 'خطأ في الاتصال بالشبكة، تأكد من الإنترنت.',
    type: AuthErrorType.network,
  );

  factory AuthException.tooManyRequests() => const AuthException._(
    message: 'محاولات كثيرة جدًا، حاول مرة أخرى لاحقًا.',
    type: AuthErrorType.tooManyRequests,
  );

  factory AuthException.unknown([String? details]) => AuthException._(
    message: 'حدث خطأ غير متوقع.${details != null ? ' $details' : ''}',
    type: AuthErrorType.unknown,
  );

  @override
  String toString() => 'AuthException(type: $type, message: $message)';
}
