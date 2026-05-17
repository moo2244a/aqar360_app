import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:aqar360/app/features/addProperty/domain/repositories/property_repository.dart';

class AddPropertyUsecase {
  final PropertyRepository propertyRepository;

  AddPropertyUsecase({required this.propertyRepository});
  Future<void> call(PropertyDetails propertyModel) async {
    await propertyRepository.addProperty(propertyModel);
  }
}
