import 'package:aqar360/app/core/utils/firebase_helper.dart';
import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_model.dart';

abstract class RfqDataSources {
  Future<void> sendRfq(RfqModel rfq);
}

class RfqDataSourcesImpl extends RfqDataSources {
  @override
  Future<void> sendRfq(rfq) async {
    await FirebaseHelper.addRfq(rfq);
  }
}
