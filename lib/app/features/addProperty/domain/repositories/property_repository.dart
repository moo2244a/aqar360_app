import 'package:aqar360/app/core/constants/property_status.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';

abstract class PropertyRepository {
  Future<void> addProperty(PropertyDetails propertyModel);
  Future<List<PropertyDetails>> getPendingProperties();
  Future<void> updatePropertyStatus({
    required String propertyId,
    required PropertyStatus status,
    String? rejectionReason,
  });
}
