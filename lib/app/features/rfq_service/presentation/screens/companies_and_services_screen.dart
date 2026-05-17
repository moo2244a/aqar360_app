import 'package:aqar360/app/core/constants/app_strings.dart';

import 'package:aqar360/app/features/rfq_service/presentation/widgets/list_view_companies_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:aqar360/app/features/rfq_service/presentation/screens/user_rfqs_screen.dart';

class CompaniesAndServicesScreen extends StatelessWidget {
  const CompaniesAndServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F7),
      appBar: AppBar(
        title: const Text(
          AppStrings.companiesAndServices,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserRfqsScreen()),
              );
            },
            icon: const Icon(Icons.list_alt, color: Color(0xFF1B4332)),
            label: const Text(
              AppStrings.myRequests,
              style: TextStyle(
                color: Color(0xFF1B4332),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [Expanded(child: ListViewCompaniesFutureBuilder())],
        ),
      ),
    );
  }
}
