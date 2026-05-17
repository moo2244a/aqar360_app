import 'package:aqar360/app/features/user_layout/presentation/widgets/home_add_fab.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/home_app_bar.dart';
import 'package:aqar360/app/features/user_layout/presentation/widgets/home_bottom_nav.dart';

import 'package:aqar360/app/features/user_layout/presentation/widgets/user_main_layout.dart';

import 'package:aqar360/app/core/utils/firebase_helper.dart';
import 'package:aqar360/app/features/addProperty/domain/entities/property_details.dart';

import 'package:flutter/material.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({super.key});

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  int _currentIndex = 0;
  late Stream<List<PropertyDetails>> _propertiesStream;

  @override
  void initState() {
    super.initState();
    _propertiesStream = FirebaseHelper.getActiveProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // ─── AppBar ───
        appBar: _currentIndex == 0 ? const HomeAppBar() : null,

        // ─── Body ───
        body: UserMainLayout(
          currentIndex: _currentIndex,
          propertiesStream: _propertiesStream,
        ),

        // ─── FAB ───
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _currentIndex == 0 ? const HomeAddFab() : null,

        // ─── Bottom Nav ───
        bottomNavigationBar: HomeBottomNav(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
        ),
      ),
    );
  }
}
