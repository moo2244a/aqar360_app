import 'package:aqar360/app/features/admin_layout/data/datasources/user_data_sourc.dart';
import 'package:aqar360/app/features/admin_layout/data/repositories/user_repository_iml.dart';
import 'package:aqar360/app/features/admin_layout/domain/usecases/get_all_data.dart';
import 'package:aqar360/app/features/admin_layout/domain/usecases/get_data_user_with_id.dart';
import 'package:aqar360/app/features/admin_layout/domain/usecases/update_user_block_status.dart';
import 'package:aqar360/app/features/rfq_service/domain/usecases/get_companies_use_case.dart';
import 'package:aqar360/app/features/rfq_service/domain/usecases/get_user_rfqs_use_case.dart';

class UserDependencies {
  final UserDataSourceImpl userDataSourceImpl;
  final UserRepositoryImpl userRepositoryImpl;
  final GetAllUsersUsecase getAllUsersUsecase;
  final UpdateUserBlockStatusUsecase updateUserBlockStatusUsecase;
  final GetDataUserWithIdUsecase getDataUserWithIdUsecase;
  final GetUserRfqsUseCase getUserRfqsUseCase;
  final GetCompaniesUseCase getCompaniesUseCase;
  UserDependencies._({
    required this.userDataSourceImpl,
    required this.userRepositoryImpl,
    required this.getAllUsersUsecase,
    required this.updateUserBlockStatusUsecase,
    required this.getDataUserWithIdUsecase,
    required this.getUserRfqsUseCase,
    required this.getCompaniesUseCase,
  });

  factory UserDependencies.create() {
    final userDataSourceImpl = UserDataSourceImpl();

    final userRepositoryImpl = UserRepositoryImpl(
      userDataSource: userDataSourceImpl,
    );

    final getProperties = GetAllUsersUsecase(
      userRepository: userRepositoryImpl,
    );

    return UserDependencies._(
      userDataSourceImpl: userDataSourceImpl,
      userRepositoryImpl: userRepositoryImpl,
      getAllUsersUsecase: getProperties,
      updateUserBlockStatusUsecase: UpdateUserBlockStatusUsecase(
        userRepository: userRepositoryImpl,
      ),
      getDataUserWithIdUsecase: GetDataUserWithIdUsecase(
        userRepository: userRepositoryImpl,
      ),
      getUserRfqsUseCase: GetUserRfqsUseCase(
        userRepository: userRepositoryImpl,
      ),
      getCompaniesUseCase: GetCompaniesUseCase(
        userRepository: userRepositoryImpl,
      ),
    );
  }
}
