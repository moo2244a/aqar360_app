import 'package:aqar360/app/features/admin_layout/domain/repositories/user_repository.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';

class GetAllUsersUsecase {
  final UserRepository userRepository;

  GetAllUsersUsecase({required this.userRepository});
  Future<List<UserModel>> call() {
    return userRepository.getAllUsers();
  }
}
