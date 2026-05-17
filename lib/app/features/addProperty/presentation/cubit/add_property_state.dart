import 'package:aqar360/app/features/addProperty/data/models/apartment_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/land_details.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/villa_details.dart';

abstract class AddPropertyState {
  final PropertyDetails details;
  VillaDetails get villa => details as VillaDetails;
  ApartmentDetails get apartment => details as ApartmentDetails;
  LandDetails get land => details as LandDetails;

  AddPropertyState({required this.details});
}

final class AddPropertyInitial extends AddPropertyState {
  AddPropertyInitial({required super.details});
}

final class AddPropertyUpdated extends AddPropertyState {
  AddPropertyUpdated({required super.details});
}

class AddDocumentImageLoading extends AddPropertyState {
  AddDocumentImageLoading({required super.details});
}

class AddPropertyImageLoading extends AddPropertyState {
  AddPropertyImageLoading({required super.details});
}

class AddImageSuccess extends AddPropertyState {
  AddImageSuccess({required super.details});
}

class AddImageError extends AddPropertyState {
  final String message;
  AddImageError(this.message, {required super.details});
}

class AddPropertyLoading extends AddPropertyState {
  AddPropertyLoading({required super.details});
}

class AddPropertySuccess extends AddPropertyState {
  final String message;
  AddPropertySuccess({required super.details, required this.message});
}

class AddPropertyError extends AddPropertyState {
  final String message;

  AddPropertyError(this.message, {required super.details});
}
