// add_property_toggle_chip.dart

import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AddPropertyToggleChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Function() onTap;

  const AddPropertyToggleChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.buttonBlue
              : AppColors.buttonBlue.withValues(alpha: .08),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.slateBlueGray,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
