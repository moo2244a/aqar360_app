import 'package:aqar360/app/core/utils/firebase_helper.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';
import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_model.dart';

abstract class UserDataSource {
  Future<List<UserModel>> getAllUsers();
  Future<void> updateUserBlockStatus(String uid, bool isBlock);
  Future<UserModel?> getDataUserWithId();
  Stream<List<RfqModel>> getUserRfqs();
  Future<List<UserModel>> getCompanies();
}

class UserDataSourceImpl implements UserDataSource {
  @override
  Future<List<UserModel>> getAllUsers() async {
    return await FirebaseHelper.getAllUsers();
  }

  @override
  Future<void> updateUserBlockStatus(String uid, bool isBlock) async {
    await FirebaseHelper.updateUserBlockStatus(uid, isBlock);
  }

  @override
  Future<UserModel?> getDataUserWithId() async {
    return await FirebaseHelper.getDataUserWithId();
  }

  @override
  Stream<List<RfqModel>> getUserRfqs() {
    return FirebaseHelper.getUserRfqs();
  }

  @override
  Future<List<UserModel>> getCompanies() async {
    return await FirebaseHelper.getCompanies();
  }
}
