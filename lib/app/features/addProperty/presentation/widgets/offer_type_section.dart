import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_cubit.dart';
import 'package:aqar360/app/features/addProperty/presentation/widgets/add_property_toggle_chip__bloc_widget.dart';
import 'package:flutter/material.dart';

class OfferTypeSection extends StatelessWidget {
  const OfferTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AddPropertyToggleChipBlocWidget(
          label: AppStrings.offerForSale,
          selected: (state) {
            return state.details.isForSale;
          },
          onTap: () => AddPropertyCubit.get(context).setForSale(true),
        ),
        const SizedBox(width: 10),
        AddPropertyToggleChipBlocWidget(
          label: AppStrings.offerForRent,
          selected: (state) {
            return !state.details.isForSale;
          },
          onTap: () => AddPropertyCubit.get(context).setForSale(false),
        ),
      ],
    );
  }
}
