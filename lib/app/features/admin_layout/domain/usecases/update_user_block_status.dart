import 'package:aqar360/app/features/admin_layout/domain/repositories/user_repository.dart';

class UpdateUserBlockStatusUsecase {
  final UserRepository userRepository;

  UpdateUserBlockStatusUsecase({required this.userRepository});
  Future<void> call({required String uid, required bool isBlock}) async {
    return await userRepository.updateUserBlockStatus(uid, isBlock);
  }
}
