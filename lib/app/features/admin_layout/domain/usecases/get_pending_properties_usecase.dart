import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:aqar360/app/features/addProperty/domain/repositories/property_repository.dart';

class GetPendingPropertiesUsecase {
  final PropertyRepository propertyRepository;

  GetPendingPropertiesUsecase({required this.propertyRepository});
  Future<List<PropertyDetails>> call() async {
    return await propertyRepository.getPendingProperties();
  }
}
