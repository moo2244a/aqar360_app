import 'package:aqar360/app/features/addProperty/data/models/apartment_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/land_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/villa_details.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/apartment_card.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/home_headline.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/home_property_section.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/home_search_bar.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/land_card.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/villa_card.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({
    super.key,
    required this.villas,
    required this.apartments,
    required this.lands,
  });

  final List<VillaDetails> villas;
  final List<ApartmentDetails> apartments;
  final List<LandDetails> lands;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Headline
        const HomeHeadline(),

        // Search Bar
        const HomeSearchBar(),

        const SliverToBoxAdapter(child: SizedBox(height: 14)),

        // ─── Section: البيوت ───
        if (villas.isNotEmpty)
          HomePropertySection(
            title: "الفيلل",
            itemCount: villas.length,
            itemBuilder: (context, index) {
              final villa = villas[index];
              return VillaCard(villaModel: villa, onFavoriteTap: () {});
            },
          ),

        // ─── Section: الشقق ───
        if (apartments.isNotEmpty)
          HomePropertySection(
            title: "الشقق",
            itemCount: apartments.length,
            itemBuilder: (context, index) {
              final apartment = apartments[index];
              return ApartmentCard(
                apartmentModel: apartment,
                onFavoriteTap: () {},
              );
            },
          ),

        // ─── Section: الأراضي ───
        if (lands.isNotEmpty)
          HomePropertySection(
            title: "الأراضي",
            itemCount: lands.length,
            itemBuilder: (context, index) {
              final land = lands[index];
              return LandCard(landModel: land, onFavoriteTap: () {});
            },
          ),
      ],
    );
  }
}
