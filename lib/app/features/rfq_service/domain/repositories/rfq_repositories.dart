import 'package:aqar360/app/core/errors/firebase_exception.dart';
import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_model.dart';
import 'package:dartz/dartz.dart';

abstract class RfqRepositories {
  Future<Either<FirebaseFireStoreException, void>> sendRfq(RfqModel rfq);
}
