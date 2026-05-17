import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/core/constants/property_type.dart';
import 'package:flutter/material.dart';

class TypeChipRow extends StatelessWidget {
  final PropertyType selected;
  final ValueChanged<PropertyType> onChanged;

  const TypeChipRow({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        _chip(context, AppStrings.all, PropertyType.all),
        _chip(context, AppStrings.typeVilla, PropertyType.villa),
        _chip(context, AppStrings.typeApartment, PropertyType.apartment),
        _chip(context, AppStrings.typeLand, PropertyType.land),
      ],
    );
  }

  Widget _chip(BuildContext ctx, String label, PropertyType type) {
    final isSelected = selected == type;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onChanged(type),
    );
  }
}
