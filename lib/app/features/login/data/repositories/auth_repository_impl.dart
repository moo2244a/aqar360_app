import 'package:aqar360/app/features/login/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:aqar360/app/core/errors/auth_exception.dart';
import 'package:aqar360/app/features/login/data/datasources/auth_remote_data_source.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AuthException, UserModel>> login(UserModel user) async {
    try {
      final result = await remoteDataSource.login(user);
      return Right(result);
    } on AuthException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AuthException.unknown(e.toString()));
    }
  }

  @override
  Future<Either<AuthException, UserModel>> register(UserModel user) async {
    try {
      final result = await remoteDataSource.register(user);
      return Right(result);
    } on AuthException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AuthException.unknown(e.toString()));
    }
  }

  // @override
  // Future<Either<AuthException, void>> signOut() async {
  //   try {
  //     await remoteDataSource.signOut();
  //     return const Right(null);
  //   } on AuthException catch (e) {
  //     return Left(e);
  //   } catch (e) {
  //     return Left(AuthException.unknown(e.toString()));
  //   }
  // }
}
