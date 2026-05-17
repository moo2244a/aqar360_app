import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/core/utils/app_validators.dart';
import 'package:aqar360/app/features/login/presentation/widgets/custom_auth_text_field.dart';
import 'package:flutter/material.dart';

class PropertyDetailsForm extends StatelessWidget {
  const PropertyDetailsForm({
    super.key,
    required TextEditingController titleController,
    required TextEditingController locationController,
    required TextEditingController priceController,
    required TextEditingController areaController,
    required TextEditingController propertyDetails,
  }) : _titleController = titleController,
       _locationController = locationController,
       _priceController = priceController,
       _propertyDetails = propertyDetails,
       _areaController = areaController;

  final TextEditingController _titleController;
  final TextEditingController _locationController;
  final TextEditingController _priceController;
  final TextEditingController _areaController;
  final TextEditingController _propertyDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18),
        CustomTextField(
          labelColor: Theme.of(context).primaryColor,
          controller: _titleController,
          label: AppStrings.fieldPropertyName,
          prefixIcon: Icons.title,
          validator: (value) =>
              AppValidators.requiredField(value, "اسم العقار"),
          hint: AppStrings.fieldPropertyName,
        ),

        const SizedBox(height: 12),
        CustomTextField(
          labelColor: Theme.of(context).primaryColor,
          controller: _locationController,
          label: AppStrings.fieldLocation,
          prefixIcon: Icons.location_on,
          validator: (value) => AppValidators.location(value),
          hint: AppStrings.fieldLocation,
        ),

        const SizedBox(height: 12),
        CustomTextField(
          labelColor: Theme.of(context).primaryColor,
          controller: _priceController,
          label: AppStrings.fieldPrice,
          prefixIcon: Icons.attach_money,
          keyboardType: TextInputType.number,
          hint: AppStrings.fieldPrice,
          validator: (value) => AppValidators.price(value),
        ),

        const SizedBox(height: 12),
        CustomTextField(
          controller: _areaController,
          labelColor: Theme.of(context).primaryColor,
          label: AppStrings.fieldArea,
          keyboardType: TextInputType.number,
          hint: AppStrings.fieldArea,
          validator: (value) => AppValidators.area(value),
          prefixIcon: Icons.square_foot,
        ),

        const SizedBox(height: 12),
        CustomTextField(
          labelColor: Theme.of(context).primaryColor,
          controller: _propertyDetails,
          label: AppStrings.sectionPropertyDetails,
          prefixIcon: Icons.title,
          maxLines: 3,
          validator: (value) =>
              AppValidators.requiredField(value, "تفاصيل العقار"),
          hint: AppStrings.sectionPropertyDetails,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
