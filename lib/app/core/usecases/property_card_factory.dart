import 'package:aqar360/app/features/addProperty/data/models/apartment_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/land_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/villa_details.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/apartment_card.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/land_card.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/villa_card.dart';
import 'package:flutter/material.dart';

class PropertyCardFactory {
  static Widget build({
    required PropertyDetails property,
    required VoidCallback onFavoriteTap,
    VoidCallback? onTap,
  }) {
    if (property is ApartmentDetails) {
      return ApartmentCard(
        apartmentModel: property,
        onFavoriteTap: onFavoriteTap,
      );
    }

    if (property is VillaDetails) {
      return VillaCard(villaModel: property, onFavoriteTap: onFavoriteTap);
    }

    if (property is LandDetails) {
      return LandCard(landModel: property, onFavoriteTap: onFavoriteTap);
    }

    return const SizedBox.shrink();
  }
}
