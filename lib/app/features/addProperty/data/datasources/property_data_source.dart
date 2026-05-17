import 'package:aqar360/app/core/constants/property_status.dart';
import 'package:aqar360/app/core/utils/firebase_helper.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';

abstract class PropertyDataSource {
  Future<void> addProperty(PropertyDetails propertyModel);
  Future<List<PropertyDetails>> getPendingProperties();
  Future<void> updatePropertyStatus({
    required String propertyId,
    required PropertyStatus status,
    String? rejectionReason,
  });
}

class PropertyDataSourceImpl implements PropertyDataSource {
  PropertyDataSourceImpl();

  @override
  Future<void> addProperty(PropertyDetails propertyModel) async {
    await FirebaseHelper.addProperty(propertyModel);
  }

  @override
  Future<List<PropertyDetails>> getPendingProperties() async {
    return await FirebaseHelper.getPendingProperties();
  }

  @override
  Future<void> updatePropertyStatus({
    required String propertyId,
    required PropertyStatus status,
    String? rejectionReason,
  }) async {
    return await FirebaseHelper.updatePropertyStatus(
      propertyId: propertyId,
      status: status,
      rejectionReason: rejectionReason,
    );
  }
}
