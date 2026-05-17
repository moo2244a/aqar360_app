import 'package:aqar360/app/features/admin_layout/domain/repositories/user_repository.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';

class GetDataUserWithIdUsecase {
  final UserRepository userRepository;

  GetDataUserWithIdUsecase({required this.userRepository});
  Future<UserModel?> call() {
    return userRepository.getDataUserWithId();
  }
}
