import 'package:aqar360/app/features/addProperty/presentation/widgets/add_property_switch_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_cubit.dart';
import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_state.dart';

class AddPropertySwitchTileBlocWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool Function(AddPropertyState state) value;
  final void Function(bool value) onChanged;

  const AddPropertySwitchTileBlocWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyState>(
      builder: (context, state) {
        return AddPropertySwitchTile(
          label: label,
          icon: icon,
          value: value(state),
          onChanged: onChanged,
        );
      },
    );
  }
}
