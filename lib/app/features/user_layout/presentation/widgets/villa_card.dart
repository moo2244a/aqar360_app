// villa_card.dart
import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/addProperty/data/models/villa_details.dart';
import 'package:aqar360/app/features/user_layout/presentation/screens/property_details_screen.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/image_section.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/property_details_header.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/property_feature_chip.dart';
import 'package:flutter/material.dart';

class VillaCard extends StatelessWidget {
  final VillaDetails villaModel;
  final VoidCallback onFavoriteTap;

  const VillaCard({
    super.key,

    required this.onFavoriteTap,
    required this.villaModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsScreen(property: villaModel),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.white,
        ),
        height: 370,

        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ─── Image ───
            Expanded(
              child: ImageSection(
                imageUrl: villaModel.imagesUrl![0],
                zoning: villaModel.isForSale ? "للبيع" : "للإيجار",
                price: villaModel.price!,
                isFavorite: villaModel.isFavorite,
                onFavoriteTap: onFavoriteTap,
                zoningColor: (p) =>
                    villaModel.isForSale ? Colors.green : Colors.blue,
              ),
            ),

            // ─── Title & Location ───
            PropertyDetailsHeader(
              title: villaModel.title!,
              location: villaModel.location!,
            ),

            // ─── Specs ───
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                child: Wrap(
                  spacing: 5,
                  alignment: .center,
                  runSpacing: 8,
                  children: [
                    PropertyFeatureChip(
                      iconData: Icons.square_foot,
                      label: "${villaModel.area!.toInt()} m²",
                    ),
                    PropertyFeatureChip(
                      iconData: Icons.bed,
                      label: "${villaModel.bedrooms} غرف",
                    ),
                    PropertyFeatureChip(
                      iconData: Icons.bathtub,
                      label: "${villaModel.bathrooms} حمام",
                    ),
                    PropertyFeatureChip(
                      iconData: Icons.weekend,
                      label: "${villaModel.livingRooms} صالة",
                    ),
                    PropertyFeatureChip(
                      iconData: Icons.stairs,
                      label: "${villaModel.floors} ${AppStrings.counterFloors}",
                    ),
                    if (villaModel.hasPool)
                      PropertyFeatureChip(
                        iconData: Icons.pool,
                        label: AppStrings.amenityPool,
                      ),
                    if (villaModel.hasGarden)
                      PropertyFeatureChip(
                        iconData: Icons.grass,
                        label: AppStrings.amenityGarden,
                      ),
                    if (villaModel.hasGarage)
                      PropertyFeatureChip(
                        iconData: Icons.garage,
                        label: AppStrings.amenityGarage,
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
