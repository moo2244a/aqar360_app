// apartment_card.dart

import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/addProperty/data/models/apartment_details.dart';
import 'package:aqar360/app/features/user_layout/presentation/screens/property_details_screen.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/image_section.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/property_feature_chip.dart';
import 'package:flutter/material.dart';

class ApartmentCard extends StatelessWidget {
  final ApartmentDetails apartmentModel;
  final VoidCallback onFavoriteTap;

  const ApartmentCard({
    super.key,
    required this.onFavoriteTap,
    required this.apartmentModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PropertyDetailsScreen(property: apartmentModel),
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
                imageUrl: apartmentModel.imagesUrl![0],
                zoning: apartmentModel.isForSale ? "للبيع" : "للإيجار",
                price: apartmentModel.price!,
                isFavorite: apartmentModel.isFavorite,
                onFavoriteTap: onFavoriteTap,
                zoningColor: (p) =>
                    apartmentModel.isForSale ? Colors.green : Colors.blue,
              ),
            ),
            // ─── Title & Location ───
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    apartmentModel.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.displayLarge!.copyWith(fontSize: 17),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        apartmentModel.location!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ─── Specs ───
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Wrap(
                  spacing: 5,
                  alignment: .center,
                  runSpacing: 8,
                  children: [
                    PropertyFeatureChip(
                      iconData: Icons.square_foot,
                      label: "${apartmentModel.area!.toInt()} m²",
                    ),
                    PropertyFeatureChip(
                      iconData: Icons.bed,
                      label: "${apartmentModel.bedrooms} غرف",
                    ),
                    PropertyFeatureChip(
                      iconData: Icons.bathtub,
                      label: "${apartmentModel.bathrooms} حمام",
                    ),
                    PropertyFeatureChip(
                      iconData: Icons.weekend,
                      label: "${apartmentModel.livingRooms} صالة",
                    ),
                    PropertyFeatureChip(
                      iconData: Icons.layers,
                      label:
                          "دور ${apartmentModel.floorNumber} / ${apartmentModel.totalFloors}",
                    ),
                    if (apartmentModel.hasElevator)
                      PropertyFeatureChip(
                        iconData: Icons.elevator,
                        label: AppStrings.amenityElevator,
                      ),
                    if (apartmentModel.hasParking)
                      PropertyFeatureChip(
                        iconData: Icons.local_parking,
                        label: AppStrings.amenityGarage,
                      ),
                    if (apartmentModel.hasSecurity)
                      PropertyFeatureChip(
                        iconData: Icons.security,
                        label: AppStrings.amenitySecurity,
                      ),
                    if (apartmentModel.hasBalcony)
                      PropertyFeatureChip(
                        iconData: Icons.balcony,
                        label: AppStrings.amenityBalcony,
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
