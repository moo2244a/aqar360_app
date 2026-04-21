import 'package:aqar360/app/core/utils/firebase_helper.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(UserModel userModel);
  Future<UserModel> register(UserModel userModel);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();

  @override
  Future<UserModel> login(UserModel userModel) async {
    final userCredential = await FirebaseHelper.signInWithEmailAndPassword(
      userModel,
    );

    final user = userCredential.user!;

    return UserModel(
      email: user.email!,
      password: userModel.password,
      emailVerified: user.emailVerified,
    );
  }

  @override
  Future<UserModel> register(UserModel userModel) async {
    final userCredential = await FirebaseHelper.createUserWithEmailAndPassword(
      userModel,
    );

    final user = userCredential.user!;

    return UserModel(
      email: user.email!,
      password: '',
      emailVerified: user.emailVerified,
    );
  }
}
