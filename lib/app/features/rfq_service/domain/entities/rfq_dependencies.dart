import 'package:aqar360/app/features/rfq_service/data/datasources/rfq_data_sources.dart';
import 'package:aqar360/app/features/rfq_service/data/repositories/rfq_repositories_impl.dart';
import 'package:aqar360/app/features/rfq_service/domain/usecases/send_rfq_use_case.dart';

class RfqDependencies {
  final RfqRepositoriesImpl rfqrepositoriesImpl;
  final RfqDataSourcesImpl rfqDataSourcesImpl;
  final SendRfqUseCase sendRfqUseCase;
  RfqDependencies._({
    required this.rfqrepositoriesImpl,
    required this.rfqDataSourcesImpl,
    required this.sendRfqUseCase,
  });
  factory RfqDependencies.create() {
    final RfqDataSourcesImpl rfqDataSourcesImpl = RfqDataSourcesImpl();
    final RfqRepositoriesImpl rfqrepositoriesImpl = RfqRepositoriesImpl(
      rfqDataSourcesImpl,
    );
    final SendRfqUseCase sendRfqUseCase = SendRfqUseCase(rfqrepositoriesImpl);
    return RfqDependencies._(
      rfqDataSourcesImpl: rfqDataSourcesImpl,
      rfqrepositoriesImpl: rfqrepositoriesImpl,
      sendRfqUseCase: sendRfqUseCase,
    );
  }
}
