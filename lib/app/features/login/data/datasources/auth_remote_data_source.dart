import 'package:aqar360/app/core/utils/firebase_helper.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(UserModel userModel);
  Future<UserModel> register(UserModel userModel);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();

  @override
  Future<UserModel> login(UserModel user) async {
    final userModel = await FirebaseHelper.signInWithEmailAndPassword(user);
    return userModel;
  }

  @override
  Future<UserModel> register(UserModel userModel) async {
    return await FirebaseHelper.createUserWithEmailAndPassword(userModel);
  }
}
