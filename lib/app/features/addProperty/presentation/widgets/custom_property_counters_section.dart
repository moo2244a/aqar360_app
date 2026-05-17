import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_cubit.dart';
import 'package:aqar360/app/features/addProperty/presentation/widgets/add_property_counter_bloc_widget.dart';
import 'package:flutter/material.dart';

class CustomPropertyCountersSection extends StatelessWidget {
  const CustomPropertyCountersSection({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddPropertyCounterBlocWidget(
          label: AppStrings.counterBedrooms,
          icon: Icons.bed,
          value: (state) => state.details.bedrooms,
          onChanged: (v) => AddPropertyCubit.get(context).updateBedrooms(v),
        ),

        AddPropertyCounterBlocWidget(
          label: AppStrings.counterBathrooms,
          icon: Icons.bathtub,
          value: (state) => state.details.bathrooms,
          onChanged: (v) => AddPropertyCubit.get(context).updateBathrooms(v),
        ),

        AddPropertyCounterBlocWidget(
          label: AppStrings.counterLivingRooms,
          icon: Icons.weekend,
          value: (state) => state.details.livingRooms,
          onChanged: (v) => AddPropertyCubit.get(context).updateLivingRooms(v),
        ),
      ],
    );
  }
}
