import 'package:aqar360/app/features/addProperty/data/datasources/property_data_source.dart';
import 'package:aqar360/app/features/addProperty/data/repositories/add_repository_impl.dart';

import 'package:aqar360/app/features/addProperty/domain/usecases/add_property_usecase.dart';
import 'package:aqar360/app/features/admin_layout/domain/usecases/get_pending_properties_usecase.dart';
import 'package:aqar360/app/features/admin_layout/domain/usecases/update_property_status_usecase.dart';

class PropertyDependencies {
  final PropertyDataSourceImpl propertyDataSourceImpl;
  final PropertyRepositoryImpl propertyRepositoryImpl;
  final AddPropertyUsecase addPropertyUsecase;
  final GetPendingPropertiesUsecase getPendingPropertiesUsecase;
  final UpdatePropertyStatusUsecase updatePropertyStatusUsecase;
  PropertyDependencies._({
    required this.propertyDataSourceImpl,
    required this.propertyRepositoryImpl,
    required this.addPropertyUsecase,
    required this.getPendingPropertiesUsecase,
    required this.updatePropertyStatusUsecase,
  });

  factory PropertyDependencies.create() {
    final dataSource = PropertyDataSourceImpl();
    final repository = PropertyRepositoryImpl(dataSource);
    final addPropertyUsecase = AddPropertyUsecase(
      propertyRepository: repository,
    );

    return PropertyDependencies._(
      propertyDataSourceImpl: dataSource,
      propertyRepositoryImpl: repository,
      addPropertyUsecase: addPropertyUsecase,
      getPendingPropertiesUsecase: GetPendingPropertiesUsecase(
        propertyRepository: repository,
      ),
      updatePropertyStatusUsecase: UpdatePropertyStatusUsecase(
        propertyRepository: repository,
      ),
    );
  }
}
