// add_property_switch_tile.dart

import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AddPropertySwitchTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const AddPropertySwitchTile({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(label),
      secondary: Icon(icon, color: AppColors.buttonBlue),
      activeThumbColor: AppColors.buttonBlue,
      contentPadding: EdgeInsets.zero,
    );
  }
}
