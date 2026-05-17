import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/rfq_service/domain/entities/rfq_model.dart';
import 'package:aqar360/app/features/rfq_service/presentation/screens/user_rfq_details_screen.dart';
import 'package:aqar360/app/features/rfq_service/presentation/widgets/gradient_icon_container.dart';
import 'package:aqar360/app/features/rfq_service/presentation/widgets/rfq_status_badge.dart';
import 'package:flutter/material.dart';

class UserRfqCard extends StatelessWidget {
  final RfqModel rfq;

  const UserRfqCard({super.key, required this.rfq});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 1,

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.surface, Color(0xFFF9FCFA)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: .04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(
            color: AppColors.slateBlueGray.withValues(alpha: 0.08),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserRfqDetailsScreen(rfq: rfq),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Top Row
                Row(
                  children: [
                    GradientIconContainer(
                      icon: Icons.description_outlined,
                      iconSize: 28,
                      size: 56,
                    ),
                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rfq.projectTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),

                          const SizedBox(height: 6),

                          Row(
                            children: [
                              const Icon(
                                Icons.business_outlined,
                                size: 16,
                                color: AppColors.slateBlueGray,
                              ),

                              const SizedBox(width: 5),

                              Expanded(
                                child: Text(
                                  rfq.companyName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleSmall!
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    RfqStatusBadge(status: rfq.status),
                  ],
                ),

                const SizedBox(height: 18),

                Text(
                  rfq.details,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F6F8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.visibility_outlined,
                            size: 16,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 6),
                          Text(
                            AppStrings.viewDetailsText,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),
                    GradientIconContainer(
                      icon: Icons.arrow_forward_ios_rounded,
                      iconSize: 18,
                      size: 40,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
