import 'package:aqar360/app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class CustomAppLogo extends StatelessWidget {
  const CustomAppLogo({super.key, required this.height, required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.logoApp),
            fit: BoxFit.fill,
          ),
        ),
        child: const SizedBox(),
      ),
    );
  }
}
