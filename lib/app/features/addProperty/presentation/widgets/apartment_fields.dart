import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/addProperty/presentation/widgets/custom_property_counters_section.dart';
import 'package:aqar360/app/features/addProperty/presentation/widgets/offer_type_section.dart';
import 'package:flutter/material.dart';

import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_cubit.dart';

import 'add_property_counter_bloc_widget.dart';
import 'add_property_switch_tile_bloc_widget.dart';
import 'package:aqar360/app/core/usecases/section_title.dart';

class ApartmentFields extends StatelessWidget {
  const ApartmentFields({super.key});

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
        SectionTitle(title: AppStrings.sectionApartmentDetails),
        const SizedBox(height: 12),

        CustomPropertyCountersSection(context: context),

        AddPropertyCounterBlocWidget(
          label: AppStrings.counterFloorNumber,
          icon: Icons.layers,
          value: (state) => state.apartment.floorNumber,
          onChanged: cubit.updateFloorNumber,
        ),

        AddPropertyCounterBlocWidget(
          label: AppStrings.counterTotalFloors,
          icon: Icons.layers,
          value: (state) => state.apartment.totalFloors,
          onChanged: cubit.updateTotalFloors,
        ),

        const SizedBox(height: 16),
        SectionTitle(title: AppStrings.sectionAmenities),

        AddPropertySwitchTileBlocWidget(
          label: AppStrings.amenityElevator,
          icon: Icons.elevator,
          value: (state) => state.apartment.hasElevator,
          onChanged: cubit.toggleElevator,
        ),

        AddPropertySwitchTileBlocWidget(
          label: AppStrings.amenityParking,
          icon: Icons.local_parking,
          value: (state) => state.apartment.hasParking,
          onChanged: cubit.toggleParking,
        ),

        AddPropertySwitchTileBlocWidget(
          label: AppStrings.amenitySecurity,
          icon: Icons.security,
          value: (state) => state.apartment.hasSecurity,
          onChanged: cubit.toggleSecurity,
        ),

        AddPropertySwitchTileBlocWidget(
          label: AppStrings.amenityBalcony,
          icon: Icons.balcony,
          value: (state) => state.apartment.hasBalcony,
          onChanged: cubit.toggleBalcony,
        ),
      ],
    );
  }
}
