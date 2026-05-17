import 'package:aqar360/app/core/constants/property_status.dart';

import 'package:aqar360/app/features/addProperty/domain/repositories/property_repository.dart';

class UpdatePropertyStatusUsecase {
  final PropertyRepository propertyRepository;

  UpdatePropertyStatusUsecase({required this.propertyRepository});
  Future<void> call({
    required String propertyId,
    required PropertyStatus status,
    String? rejectionReason,
  }) async {
    return await propertyRepository.updatePropertyStatus(
      propertyId: propertyId,
      status: status,
      rejectionReason: rejectionReason,
    );
  }
}
