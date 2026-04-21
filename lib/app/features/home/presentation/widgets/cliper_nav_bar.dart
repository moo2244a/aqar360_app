import 'package:flutter/material.dart';

class CustomNavigationBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, 0);

    // بداية الكيرف
    path.lineTo(size.width * 0.38, 0);

    path.quadraticBezierTo(
      size.width * 0.5,
      size.height, // عمق الكيرف
      size.width * 0.62,
      0,
    );

    // باقي البار
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
