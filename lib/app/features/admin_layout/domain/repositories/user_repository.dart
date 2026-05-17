import 'package:aqar360/app/features/login/data/models/user_model.dart';
import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getAllUsers();
  Future<void> updateUserBlockStatus(String uid, bool isBlock);
  Future<UserModel?> getDataUserWithId();
  Stream<List<RfqModel>> getUserRfqs();
  Future<List<UserModel>> getCompanies();
}
