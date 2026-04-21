import 'package:aqar360/app/features/login/data/datasources/auth_remote_data_source.dart';
import 'package:aqar360/app/features/login/data/repositories/auth_repository_impl.dart';
import 'package:aqar360/app/features/login/domain/usecases/login_usecase.dart';
import 'package:aqar360/app/features/login/domain/usecases/register_usecase.dart';

class AuthDependencies {
  final AuthRemoteDataSourceImpl remoteDataSource;
  final AuthRepositoryImpl authRepository;
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;

  AuthDependencies._({
    required this.remoteDataSource,
    required this.authRepository,
    required this.loginUsecase,
    required this.registerUsecase,
  });

  factory AuthDependencies.create() {
    final remote = AuthRemoteDataSourceImpl();
    final repo = AuthRepositoryImpl(remote);
    final login = LoginUsecase(repo);
    final register = RegisterUsecase(repo);
    return AuthDependencies._(
      remoteDataSource: remote,
      authRepository: repo,
      loginUsecase: login,
      registerUsecase: register,
    );
  }
}
