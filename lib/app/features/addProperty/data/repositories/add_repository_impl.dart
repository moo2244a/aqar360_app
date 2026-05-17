import 'package:aqar360/app/core/constants/property_status.dart';
import 'package:aqar360/app/features/addProperty/data/datasources/property_data_source.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:aqar360/app/features/addProperty/domain/repositories/property_repository.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyDataSource propertyDataSource;

  PropertyRepositoryImpl(this.propertyDataSource);

  @override
  Future<void> addProperty(PropertyDetails propertyModel) async {
    await propertyDataSource.addProperty(propertyModel);
  }

  @override
  Future<List<PropertyDetails>> getPendingProperties() async {
    return await propertyDataSource.getPendingProperties();
  }

  Future<void> updatePropertyStatus({
    required String propertyId,
    required PropertyStatus status,
    String? rejectionReason,
  }) async {
    return await propertyDataSource.updatePropertyStatus(
      propertyId: propertyId,
      status: status,
      rejectionReason: rejectionReason,
    );
  }
}
