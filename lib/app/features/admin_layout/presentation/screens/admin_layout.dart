import 'package:aqar360/app/features/admin_layout/presentation/screens/admin_properties_screen.dart';
import 'package:aqar360/app/features/admin_layout/presentation/screens/admin_users_screen.dart';
import 'package:flutter/material.dart';

class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const AdminUsersScreen(),
    const AdminPropertiesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Panel")),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Users"),
          BottomNavigationBarItem(
            icon: Icon(Icons.real_estate_agent),
            label: "Properties",
          ),
        ],
      ),
    );
  }
}
