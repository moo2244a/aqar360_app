import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/admin_layout/domain/entities/user_dependencies.dart';
import 'package:aqar360/app/features/login/data/models/user_model.dart';
import 'package:aqar360/app/features/rfq_service/presentation/screens/rfq_screen.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/company_card.dart';
import 'package:flutter/material.dart';

class ListViewCompaniesFutureBuilder extends StatelessWidget {
  const ListViewCompaniesFutureBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final dependencies = UserDependencies.create();
    return FutureBuilder<List<UserModel>>(
      future: dependencies.getCompaniesUseCase(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('حدث خطأ: ${snapshot.error}'));
        }

        final companiesList = snapshot.data ?? [];

        if (companiesList.isEmpty) {
          return const Center(child: Text(AppStrings.noRegisteredCompanies));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: companiesList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final company = companiesList[index];
            return CompanyCard(
              title: company.name!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RfqScreen(companyModel: company),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
