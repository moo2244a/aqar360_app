import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/core/constants/property_type.dart';
import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_cubit.dart';

import 'package:aqar360/app/features/addProperty/presentation/widgets/add_property_type_button.dart';
import 'package:flutter/material.dart';

class PropertyTypeSelector extends StatelessWidget {
  const PropertyTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AddPropertyTypeButton(
          label: AppStrings.typeVilla,
          icon: Icons.villa,

          propertyType: PropertyType.villa,
          onTap: AddPropertyCubit.get(context).onTapCurrentProperty(),
        ),
        const SizedBox(width: 10),
        AddPropertyTypeButton(
          label: AppStrings.typeApartment,
          icon: Icons.apartment,
          propertyType: PropertyType.apartment,
          onTap: AddPropertyCubit.get(context).onTapCurrentProperty(),
        ),
        const SizedBox(width: 10),
        AddPropertyTypeButton(
          label: AppStrings.typeLand,
          icon: Icons.landscape,

          propertyType: PropertyType.land,
          onTap: AddPropertyCubit.get(context).onTapCurrentProperty(),
        ),
      ],
    );
  }
}
