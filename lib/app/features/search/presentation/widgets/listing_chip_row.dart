import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/core/constants/listing_type.dart';
import 'package:flutter/material.dart';

class ListingChipRow extends StatelessWidget {
  final ListingType selected;
  final ValueChanged<ListingType> onChanged;

  const ListingChipRow({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        _chip(context, AppStrings.all, ListingType.all),
        _chip(context, AppStrings.offerForSale, ListingType.forSale),
        _chip(context, AppStrings.offerForSale, ListingType.forRent),
      ],
    );
  }

  Widget _chip(BuildContext ctx, String label, ListingType type) {
    return ChoiceChip(
      label: Text(label),
      selected: selected == type,
      onSelected: (_) => onChanged(type),
    );
  }
}
