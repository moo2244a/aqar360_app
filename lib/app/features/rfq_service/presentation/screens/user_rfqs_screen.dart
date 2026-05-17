import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/admin_layout/domain/entities/user_dependencies.dart';
import 'package:aqar360/app/features/rfq_service/presentation/widgets/user_rfq_card.dart';
import 'package:flutter/material.dart';
import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_model.dart';

class UserRfqsScreen extends StatelessWidget {
  const UserRfqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dependencies = UserDependencies.create();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.previousRequestsText,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        body: StreamBuilder<List<RfqModel>>(
          stream: dependencies.getUserRfqsUseCase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('حدث خطأ: ${snapshot.error}'));
            }

            final rfqs = snapshot.data ?? [];

            if (rfqs.isEmpty) {
              return Center(
                child: Text(
                  AppStrings.noPreviousRequestsText,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: rfqs.length,
              itemBuilder: (context, index) {
                final rfq = rfqs[index];
                return UserRfqCard(rfq: rfq);
              },
            );
          },
        ),
      ),
    );
  }
}
