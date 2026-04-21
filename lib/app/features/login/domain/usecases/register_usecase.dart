import 'package:dartz/dartz.dart';
import 'package:aqar360/app/core/errors/auth_exception.dart';
import 'package:aqar360/app/features/login/domain/repositories/auth_repository.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<Either<AuthException, UserModel>> call(UserModel user) async {
    return await repository.register(user);
  }
}
