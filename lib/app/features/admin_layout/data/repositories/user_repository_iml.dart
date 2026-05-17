import 'package:aqar360/app/features/admin_layout/data/datasources/user_data_sourc.dart';
import 'package:aqar360/app/features/admin_layout/domain/repositories/user_repository.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';
import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({required this.userDataSource});
  @override
  Future<List<UserModel>> getAllUsers() async {
    return await userDataSource.getAllUsers();
  }

  @override
  Future<void> updateUserBlockStatus(String uid, bool isBlock) async {
    return await userDataSource.updateUserBlockStatus(uid, isBlock);
  }

  @override
  Future<UserModel?> getDataUserWithId() async {
    return await userDataSource.getDataUserWithId();
  }

  @override
  Stream<List<RfqModel>> getUserRfqs() {
    return userDataSource.getUserRfqs();
  }

  @override
  Future<List<UserModel>> getCompanies() async {
    return await userDataSource.getCompanies();
  }
}
