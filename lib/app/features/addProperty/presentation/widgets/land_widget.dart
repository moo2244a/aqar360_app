import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/core/utils/app_validators.dart';
import 'package:aqar360/app/features/addProperty/presentation/widgets/add_property_toggle_chip__bloc_widget.dart';
import 'package:aqar360/app/features/login/presentation/widgets/custom_auth_text_field.dart';
import 'package:flutter/material.dart';

import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_cubit.dart';

import 'add_property_switch_tile_bloc_widget.dart';

import 'package:aqar360/app/core/usecases/section_title.dart';

class LandFields extends StatelessWidget {
  final TextEditingController streetWidthController;

  const LandFields({super.key, required this.streetWidthController});

  @override
  Widget build(BuildContext context) {
    final cubit = AddPropertyCubit.get(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: AppStrings.sectionZoning),
        const SizedBox(height: 8),

        Wrap(
          spacing: 8,
          children: AppStrings.zoningOptions.map((z) {
            return AddPropertyToggleChipBlocWidget(
              label: z,
              selected: (state) => state.land.zoning == z,
              onTap: () => cubit.updateZoning(z),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),
        CustomTextField(
          labelColor: Theme.of(context).primaryColor,
          controller: streetWidthController,
          label: AppStrings.fieldStreetWidth,
          prefixIcon: Icons.route,
          keyboardType: TextInputType.number,
          hint: AppStrings.fieldStreetWidth,
          validator: (value) => AppValidators.number(value, "عرض الشارع"),
        ),

        const SizedBox(height: 16),
        SectionTitle(title: AppStrings.sectionLandFeatures),

        AddPropertySwitchTileBlocWidget(
          label: AppStrings.featureCorner,
          icon: Icons.turn_right,
          value: (state) => state.land.isCorner,
          onChanged: cubit.toggleCorner,
        ),

        AddPropertySwitchTileBlocWidget(
          label: AppStrings.featureMainStreet,
          icon: Icons.add_road,
          value: (state) => state.land.onMainStreet,
          onChanged: cubit.toggleMainStreet,
        ),

        const SizedBox(height: 16),
        SectionTitle(title: AppStrings.sectionAvailableServices),

        AddPropertySwitchTileBlocWidget(
          label: AppStrings.serviceWater,
          icon: Icons.water_drop,
          value: (state) => state.land.hasWater,
          onChanged: cubit.toggleWater,
        ),

        AddPropertySwitchTileBlocWidget(
          label: AppStrings.serviceElectricity,
          icon: Icons.bolt,
          value: (state) => state.land.hasElectricity,
          onChanged: cubit.toggleElectricity,
        ),

        AddPropertySwitchTileBlocWidget(
          label: AppStrings.serviceSewage,
          icon: Icons.plumbing,
          value: (state) => state.land.hasSewage,
          onChanged: cubit.toggleSewage,
        ),
      ],
    );
  }
}
