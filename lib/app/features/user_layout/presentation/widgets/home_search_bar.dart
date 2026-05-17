import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/search/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  final VoidCallback? onTap;

  const HomeSearchBar({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GestureDetector(
          onTap:
              onTap ??
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
          child: Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(13.8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.search, size: 22, color: Colors.black87),
                SizedBox(width: 10),
                Text(
                  AppStrings.hSearch,
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
