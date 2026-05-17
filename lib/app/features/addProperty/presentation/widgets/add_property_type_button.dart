// add_property_type_button.dart

import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/constants/property_type.dart';
import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_cubit.dart';
import 'package:aqar360/app/features/addProperty/presentation/cubit/add_property_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPropertyTypeButton extends StatelessWidget {
  final String label;
  final IconData icon;

  final PropertyType propertyType;
  final Function(PropertyType) onTap;

  const AddPropertyTypeButton({
    super.key,
    required this.label,
    required this.icon,
    required this.propertyType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(propertyType),
        child: BlocBuilder<AddPropertyCubit, AddPropertyState>(
          builder: (context, state) {
            final selected = state.details.propertyType == propertyType;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.buttonBlue
                    : AppColors.buttonBlue.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selected
                      ? AppColors.slateBlueGray
                      : Colors.transparent,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    icon,
                    color: selected ? AppColors.white : AppColors.slateBlueGray,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      color: selected
                          ? AppColors.white
                          : AppColors.midnightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
