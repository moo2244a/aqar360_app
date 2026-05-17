import 'package:aqar360/app/core/usecases/property_card_factory.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';

import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  final PropertyDetails property;

  const PropertyCard({super.key, required this.property});

  Widget? _typeLabel() {
    return SizedBox(
      height: 350,
      child: PropertyCardFactory.build(
        property: property,
        onFavoriteTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _typeLabel() ?? SizedBox();
  }
}
