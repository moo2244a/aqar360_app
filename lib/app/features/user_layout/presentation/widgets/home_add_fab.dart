import 'package:aqar360/app/features/addProperty/presentation/screens/add_property_screen.dart';
import 'package:flutter/material.dart';

class HomeAddFab extends StatelessWidget {
  const HomeAddFab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      height: 75,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPropertyScreen()),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 40),
      ),
    );
  }
}
