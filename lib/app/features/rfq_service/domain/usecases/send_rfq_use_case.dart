import 'package:aqar360/app/core/errors/firebase_exception.dart';
import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_model.dart';
import 'package:aqar360/app/features/rfq_service/domain/repositories/rfq_repositories.dart';
import 'package:dartz/dartz.dart';

class SendRfqUseCase {
  RfqRepositories rfqRepositories;
  SendRfqUseCase(this.rfqRepositories);
  Future<Either<FirebaseFireStoreException, void>> call(RfqModel rfq) async {
    return await rfqRepositories.sendRfq(rfq);
  }
}
