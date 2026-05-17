import 'package:aqar360/app/features/admin_layout/domain/repositories/user_repository.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';

class GetCompaniesUseCase {
  final UserRepository userRepository;

  GetCompaniesUseCase({required this.userRepository});
  Future<List<UserModel>> call() async {
    return await userRepository.getCompanies();
  }
}
