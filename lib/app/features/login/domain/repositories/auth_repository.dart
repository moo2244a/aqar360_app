import 'package:dartz/dartz.dart';
import 'package:aqar360/app/core/errors/auth_exception.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<AuthException, UserModel>> login(UserModel user);
  Future<Either<AuthException, UserModel>> register(UserModel user);
  // Future<Either<AuthException, void>> signOut();
}
