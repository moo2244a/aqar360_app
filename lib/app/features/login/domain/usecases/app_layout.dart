import 'package:aqar360/app/core/constants/user_role.dart';
import 'package:aqar360/app/features/admin_layout/presentation/screens/admin_layout.dart';
import 'package:aqar360/app/features/company_layout/presentation/screens/company_layout.dart';
import 'package:aqar360/app/features/user_layout/presentation/screens/user_layout_screen.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  final UserRole role;

  const AppLayout({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    switch (role) {
      case UserRole.admin:
        return const AdminLayout();

      case UserRole.company:
        return const CompanyLayout();

      case UserRole.user:
        return const UserLayout();
    }
  }
}
