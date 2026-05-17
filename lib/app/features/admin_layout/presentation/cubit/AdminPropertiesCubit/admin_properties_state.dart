import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';

abstract class AdminPropertiesState {}

class AdminPropertiesInitial extends AdminPropertiesState {}

class AdminPropertiesLoading extends AdminPropertiesState {}

class AdminPropertiesLoaded extends AdminPropertiesState {
  final List<PropertyDetails> properties;

  AdminPropertiesLoaded(this.properties);
}

class AdminPropertiesError extends AdminPropertiesState {
  final String message;

  AdminPropertiesError(this.message);
}

class AdminPropertiesSuccess extends AdminPropertiesState {
  final String message;

  AdminPropertiesSuccess(this.message);
}
