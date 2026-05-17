import 'package:aqar360/app/features/addProperty/data/models/apartment_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/land_details.dart';
import 'package:aqar360/app/features/addProperty/data/models/villa_details.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';
import 'package:aqar360/app/features/rfq_service/presentation/screens/companies_and_services_screen.dart';
import 'package:aqar360/app/features/user_layout/presentation/screens/my_purchases_screen.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/user_home_screen.dart';
import 'package:flutter/material.dart';

class UserMainLayout extends StatelessWidget {
  const UserMainLayout({
    super.key,
    required this.currentIndex,
    required this.propertiesStream,
  });
  final int currentIndex;
  final Stream<List<PropertyDetails>> propertiesStream;
  @override
  Widget build(BuildContext context) {
    if (currentIndex == 2) {
      return MyPurchasesScreen();
    }
    if (currentIndex == 3) {
      return const CompaniesAndServicesScreen();
    }
    if (currentIndex == 1) {
      return const Center(
        child: Text(
          "قريباً...",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }
    return StreamBuilder<List<PropertyDetails>>(
      stream: propertiesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('حدث خطأ: ${snapshot.error}'));
        }

        final allProperties = snapshot.data ?? [];

        // Filter by type
        final villas = allProperties.whereType<VillaDetails>().toList();
        final apartments = allProperties.whereType<ApartmentDetails>().toList();
        final lands = allProperties.whereType<LandDetails>().toList();

        return UserHomeScreen(
          villas: villas,
          apartments: apartments,
          lands: lands,
        );
      },
    );
  }
}
