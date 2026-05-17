import 'package:aqar360/app/features/admin_layout/domain/repositories/user_repository.dart';
import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_model.dart';

class GetUserRfqsUseCase {
  final UserRepository userRepository;

  GetUserRfqsUseCase({required this.userRepository});
  Stream<List<RfqModel>> call() {
    return userRepository.getUserRfqs();
  }
}
