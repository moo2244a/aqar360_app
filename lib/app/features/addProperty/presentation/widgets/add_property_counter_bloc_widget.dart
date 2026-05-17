import 'package:aqar360/app/features/addProperty/presentation/widgets/add_property_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_cubit.dart';
import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_state.dart';

class AddPropertyCounterBlocWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final int Function(AddPropertyState state) value;
  final void Function(int value) onChanged;

  const AddPropertyCounterBlocWidget({
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
        return AddPropertyCounter(
          label: label,
          icon: icon,
          value: value(state),
          onChanged: onChanged,
        );
      },
    );
  }
}
