import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/custom_app_logo.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/custom_top_brand_bar.dart';
import 'package:aqar360/app/core/utils/firebase_helper.dart';
import 'package:aqar360/app/core/models/notification_model.dart';
import 'package:aqar360/app/features/user_layout/presentation/screens/notifications_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  const HomeAppBar({super.key, this.onNotificationTap, this.onProfileTap});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: CustomAppLogo(height: 60, width: 80),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: CustomTopBrandBar(
          textStyle: Theme.of(
            context,
          ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      actions: [
        StreamBuilder<List<NotificationModel>>(
          stream: FirebaseHelper.getUserNotifications(
            FirebaseAuth.instance.currentUser?.uid ?? '',
          ),
          builder: (context, snapshot) {
            final unreadCount =
                snapshot.data?.where((n) => !n.isRead).length ?? 0;
            return Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.notifications_active_outlined,
                    color: AppColors.slateBlueGray,
                    size: 35,
                  ),
                ),
                if (unreadCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$unreadCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        IconButton(
          onPressed: onProfileTap ?? () {},
          icon: const Icon(
            Icons.person_2,
            color: AppColors.slateBlueGray,
            size: 35,
          ),
        ),
      ],
    );
  }
}
