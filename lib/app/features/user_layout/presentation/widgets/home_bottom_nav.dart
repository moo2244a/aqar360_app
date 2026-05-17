import 'package:aqar360/app/features/user_layout/presentation/widgets/bottom_nav_item.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/cliper_nav_bar.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/customer_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomNavigationBar(),
      child: CustomBottomNavigationBar(
        actions: [
          BottomNavItem(
            icon: Icons.home_outlined,
            title: "الرئيسية",
            index: 0,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          BottomNavItem(
            icon: Icons.map_outlined,
            title: "الخريطة",
            index: 1,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          const SizedBox(width: 60),
          BottomNavItem(
            icon: Icons.house_siding_outlined,
            title: "عقاراتي",
            index: 2,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          BottomNavItem(
            icon: Icons.miscellaneous_services_outlined,
            title: "الخدمات",
            index: 3,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
