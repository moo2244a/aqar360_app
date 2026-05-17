import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/addProperty/presentation/widgets/custom_property_counters_section.dart';
import 'package:aqar360/app/features/addProperty/presentation/widgets/offer_type_section.dart';
import 'package:flutter/material.dart';

import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_cubit.dart';

import 'add_property_counter_bloc_widget.dart';
import 'add_property_switch_tile_bloc_widget.dart';
import 'package:aqar360/app/core/usecases/section_title.dart';

class VillaFields extends StatelessWidget {
  const VillaFields({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AddPropertyCubit.get(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: AppStrings.sectionOfferType),
        const SizedBox(height: 8),
        OfferTypeSection(),
        const SizedBox(height: 24),
        SectionTitle(title: AppStrings.sectionVillaDetails),
        const SizedBox(height: 12),
        CustomPropertyCountersSection(context: context),
        AddPropertyCounterBlocWidget(
          label: AppStrings.counterFloors,
          icon: Icons.stairs,
          value: (state) => state.villa.floors,
          onChanged: cubit.updateFloors,
        ),

        const SizedBox(height: 16),

        SectionTitle(title: AppStrings.sectionAmenities),
        const SizedBox(height: 8),

        AddPropertySwitchTileBlocWidget(
          label: AppStrings.amenityPool,
          icon: Icons.pool,
          value: (state) => state.villa.hasPool,
          onChanged: cubit.togglePool,
        ),

        AddPropertySwitchTileBlocWidget(
          label: AppStrings.amenityGarden,
          icon: Icons.grass,
          value: (state) => state.villa.hasGarden,
          onChanged: cubit.toggleGarden,
        ),

        AddPropertySwitchTileBlocWidget(
          label: AppStrings.amenityGarage,
          icon: Icons.garage,
          value: (state) => state.villa.hasGarage,
          onChanged: cubit.toggleGarage,
        ),
      ],
    );
  }
}
