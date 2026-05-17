import 'package:aqar360/app/features/addProperty/presentation/widgets/add_property_toggle_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_cubit.dart';
import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_state.dart';

class AddPropertyToggleChipBlocWidget extends StatelessWidget {
  final String label;

  final bool Function(AddPropertyState) selected;
  final void Function() onTap;

  const AddPropertyToggleChipBlocWidget({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyState>(
      builder: (context, state) {
        return AddPropertyToggleChip(
          label: label,
          selected: selected(state),
          onTap: onTap,
        );
      },
    );
  }
}
