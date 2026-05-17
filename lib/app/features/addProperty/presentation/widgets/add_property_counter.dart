// add_property_counter.dart

import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AddPropertyCounter extends StatelessWidget {
  final String label;
  final IconData icon;
  final int value;
  final ValueChanged<int> onChanged;
  final int minValue;

  const AddPropertyCounter({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.onChanged,
    this.minValue = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: AppColors.backgroundWhite, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColors.midnightBlue),
            ),
          ),
          IconButton(
            onPressed: value > minValue ? () => onChanged(value - 1) : null,
            icon: const Icon(Icons.remove_circle_outline),
            color: AppColors.buttonBlue,
          ),
          Text("$value", style: Theme.of(context).textTheme.bodyLarge),
          IconButton(
            onPressed: () => onChanged(value + 1),
            icon: const Icon(Icons.add_circle_outline),
            color: AppColors.buttonBlue,
          ),
        ],
      ),
    );
  }
}
