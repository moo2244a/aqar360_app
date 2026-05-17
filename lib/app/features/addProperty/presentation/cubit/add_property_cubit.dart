import 'package:aqar360/app/core/constants/property_type.dart';
import 'package:aqar360/app/features/addProperty/data/models/apartment_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/land_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/villa_details.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:aqar360/app/features/addProperty/domain/usecases/add_image_use_case.dart'
    show AddImageUseCase;
import 'package:aqar360/app/features/addProperty/domain/usecases/add_property_usecase.dart';
import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPropertyCubit extends Cubit<AddPropertyState> {
  AddPropertyCubit({required this.addPropertyUsecase})
    : super(AddPropertyInitial(details: VillaDetails()));

  static AddPropertyCubit get(BuildContext context) =>
      BlocProvider.of<AddPropertyCubit>(context);

  PropertyDetails details = VillaDetails();

  final VillaDetails _villaDetails = VillaDetails();
  final ApartmentDetails _apartmentDetails = ApartmentDetails();
  final LandDetails _landDetails = LandDetails();
  final AddPropertyUsecase addPropertyUsecase;

  // ─── helpers ────────────────────────────────────────────────────────────────

  void _emitUpdated() => emit(AddPropertyUpdated(details: details));

  ApartmentDetails get _apartment => details as ApartmentDetails;
  LandDetails get _land => details as LandDetails;
  VillaDetails get _villa => details as VillaDetails;

  // ─── submit ─────────────────────────────────────────────────────────────────

  Future<void> addProperty({
    required TextEditingController titleController,
    required TextEditingController locationController,
    required TextEditingController priceController,
    required TextEditingController areaController,
    required TextEditingController streetWidthController,
    required TextEditingController propertyDetailsController,
  }) async {
    try {
      emit(AddPropertyLoading(details: details));

      details = details.copyWithBase(
        title: titleController.text,
        location: locationController.text,
        price: double.tryParse(priceController.text) ?? 0,
        area: double.tryParse(areaController.text) ?? 0,
        propertyDetails: propertyDetailsController.text,
      );

      // streetWidth is land-only — use copyWith, not direct mutation
      if (details is LandDetails) {
        details = _land.copyWithBase(
          streetWidth: double.tryParse(streetWidthController.text) ?? 0,
        );
      }

      await addPropertyUsecase(details);

      emit(
        AddPropertySuccess(
          details: details,
          message: ' تم اضافة العقار انتظار الموافق علية من المسؤل',
        ),
      );
    } catch (e) {
      emit(AddPropertyError(e.toString(), details: details));
    }
  }

  // ─── images ─────────────────────────────────────────────────────────────────

  Future<void> addPropertyImage() async {
    emit(AddPropertyImageLoading(details: details));
    try {
      final imageUrl = await AddImageUseCase.call();
      if (isClosed) return;
      if (imageUrl == null) {
        emit(AddImageError("لا تتم اختيار الصورة", details: details));
        return;
      }
      details = details.copyWithBase(
        imagesUrl: [...?details.imagesUrl, imageUrl],
      );
      if (!isClosed) {
        emit(AddImageSuccess(details: details));
      }
    } catch (e) {
      if (!isClosed) {
        emit(AddImageError(e.toString(), details: details));
      }
    }
  }

  Future<void> addDocumentImage() async {
    emit(AddDocumentImageLoading(details: details));
    try {
      final docUrl = await AddImageUseCase.call();
      if (isClosed) return;
      if (docUrl == null) {
        emit(AddImageError("لا تتم اختيار الصورة", details: details));
        return;
      }
      details = details.copyWithBase(
        imagesDocUrl: [...?details.imagesDocUrl, docUrl],
      );
      if (!isClosed) {
        emit(AddImageSuccess(details: details));
      }
    } catch (e) {
      if (!isClosed) {
        emit(AddImageError(e.toString(), details: details));
      }
    }
  }

  // ─── property type ───────────────────────────────────────────────────────────

  PropertyDetails _createPropertyDetails(PropertyType type) {
    switch (type) {
      case PropertyType.villa:
        return _villaDetails;
      case PropertyType.apartment:
        return _apartmentDetails;
      case PropertyType.land:
        return _landDetails;
      case PropertyType.all:
        throw UnimplementedError();
    }
  }

  Function(PropertyType) onTapCurrentProperty() => (PropertyType type) {
    details = _createPropertyDetails(type);

    emit(AddPropertyUpdated(details: details));
  };

  // ─── base fields ─────────────────────────────────────────────────────────────

  void setForSale(bool value) {
    details = details.copyWithBase(isForSale: value);
    _emitUpdated();
  }

  void updateBedrooms(int value) {
    details = details.copyWithBase(bedrooms: value);
    _emitUpdated();
  }

  void updateBathrooms(int value) {
    details = details.copyWithBase(bathrooms: value);
    _emitUpdated();
  }

  void updateLivingRooms(int value) {
    details = details.copyWithBase(livingRooms: value);
    _emitUpdated();
  }

  // ─── apartment fields ────────────────────────────────────────────────────────

  void updateFloorNumber(int value) {
    details = _apartment.copyWithBase(floorNumber: value);
    _emitUpdated();
  }

  void updateTotalFloors(int value) {
    details = _apartment.copyWithBase(totalFloors: value);
    _emitUpdated();
  }

  void toggleElevator(bool value) {
    details = _apartment.copyWithBase(hasElevator: value);
    _emitUpdated();
  }

  void toggleParking(bool value) {
    details = _apartment.copyWithBase(hasParking: value);
    _emitUpdated();
  }

  void toggleSecurity(bool value) {
    details = _apartment.copyWithBase(hasSecurity: value);
    _emitUpdated();
  }

  void toggleBalcony(bool value) {
    details = _apartment.copyWithBase(hasBalcony: value);
    _emitUpdated();
  }

  // ─── land fields ─────────────────────────────────────────────────────────────

  void updateZoning(String value) {
    details = _land.copyWithBase(zoning: value);
    _emitUpdated();
  }

  void updateStreetWidth(double value) {
    details = _land.copyWithBase(streetWidth: value);
    _emitUpdated();
  }

  void toggleCorner(bool value) {
    details = _land.copyWithBase(isCorner: value);
    _emitUpdated();
  }

  void toggleMainStreet(bool value) {
    details = _land.copyWithBase(onMainStreet: value);
    _emitUpdated();
  }

  void toggleWater(bool value) {
    details = _land.copyWithBase(hasWater: value);
    _emitUpdated();
  }

  void toggleElectricity(bool value) {
    details = _land.copyWithBase(hasElectricity: value);
    _emitUpdated();
  }

  void toggleSewage(bool value) {
    details = _land.copyWithBase(hasSewage: value);
    _emitUpdated();
  }

  // ─── villa fields ────────────────────────────────────────────────────────────

  void updateFloors(int value) {
    details = _villa.copyWithBase(floors: value);
    _emitUpdated();
  }

  void togglePool(bool value) {
    details = _villa.copyWithBase(hasPool: value);
    _emitUpdated();
  }

  void toggleGarden(bool value) {
    details = _villa.copyWithBase(hasGarden: value);
    _emitUpdated();
  }

  void toggleGarage(bool value) {
    details = _villa.copyWithBase(hasGarage: value);
    _emitUpdated();
  }
}
