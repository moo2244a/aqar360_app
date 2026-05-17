import 'package:aqar360/app/core/errors/firebase_exception.dart';
import 'package:aqar360/app/features/rfq_service/data/datasources/rfq_data_sources.dart';
import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_model.dart';
import 'package:aqar360/app/features/rfq_service/domain/repositories/rfq_repositories.dart';
import 'package:dartz/dartz.dart';

class RfqRepositoriesImpl extends RfqRepositories {
  RfqDataSources rfqDataSources;
  RfqRepositoriesImpl(this.rfqDataSources);
  @override
  Future<Either<FirebaseFireStoreException, void>> sendRfq(RfqModel rfq) async {
    try {
      return Right(await rfqDataSources.sendRfq(rfq));
    } on FirebaseFireStoreException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(FirebaseFireStoreException.unknown());
    }
  }
}
