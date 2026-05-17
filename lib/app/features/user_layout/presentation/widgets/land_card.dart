// land_card.dart
import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/addProperty/data/models/land_details.dart';
import 'package:aqar360/app/features/user_layout/presentation/screens/property_details_screen.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/image_section.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/property_details_header.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/property_feature_chip.dart';
import 'package:flutter/material.dart';

class LandCard extends StatelessWidget {
  final LandDetails landModel;
  final VoidCallback onFavoriteTap;
  final Widget? childButton;
  const LandCard({
    super.key,

    required this.onFavoriteTap,
    required this.landModel,
    this.childButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsScreen(property: landModel),
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
                imageUrl: landModel.imagesUrl![0],
                zoning: landModel.zoning!,
                price: landModel.price!,
                isFavorite: landModel.isFavorite,
                onFavoriteTap: onFavoriteTap,
                zoningColor: _zoningColor,
              ),
            ),

            PropertyDetailsHeader(
              title: landModel.title!,
              location: landModel.location!,
            ),

            // ─── Specs ───
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                child: Wrap(
                  alignment: .center,
                  spacing: 5,
                  runSpacing: 8,
                  children: [
                    PropertyFeatureChip(
                      iconData: Icons.square_foot,
                      label: "${landModel.area!.toInt()} m²",
                    ),
                    PropertyFeatureChip(
                      iconData: Icons.route,
                      label: "عرض الشارع ${landModel.streetWidth!.toInt()}م",
                    ),
                    if (landModel.isCorner)
                      PropertyFeatureChip(
                        iconData: Icons.turn_right,
                        label: AppStrings.featureCorner,
                      ),
                    if (landModel.onMainStreet)
                      PropertyFeatureChip(
                        iconData: Icons.add_road,
                        label: AppStrings.featureMainStreet,
                      ),
                    if (landModel.hasWater)
                      PropertyFeatureChip(
                        iconData: Icons.water_drop,
                        label: AppStrings.serviceWater,
                      ),
                    if (landModel.hasElectricity)
                      PropertyFeatureChip(
                        iconData: Icons.bolt,
                        label: AppStrings.serviceElectricity,
                      ),
                    if (landModel.hasSewage)
                      PropertyFeatureChip(
                        iconData: Icons.plumbing,
                        label: AppStrings.serviceSewage,
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Color _zoningColor(String zoning) {
    switch (zoning) {
      case AppStrings.zoningResidential:
        return Colors.green;
      case AppStrings.zoningCommercial:
        return Colors.blue;
      case AppStrings.zoningAgricultural:
        return Colors.lightGreen;
      case AppStrings.zoningIndustrial:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
