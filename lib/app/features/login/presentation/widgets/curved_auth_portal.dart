import 'package:flutter/material.dart';

class CurvedAuthPortal extends StatelessWidget {
  const CurvedAuthPortal({
    super.key,
    this.margin = 0,
    this.height,
    required this.color,
    this.child,
    this.gradient,
  });

  final double margin;
  final Color color;
  final Widget? child;
  final Gradient? gradient;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: margin, left: margin, right: margin),
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        border: const Border(
          top: BorderSide(color: Color.fromARGB(255, 26, 111, 238), width: 3),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MediaQuery.sizeOf(context).width / 2),
          topRight: Radius.circular(MediaQuery.sizeOf(context).width / 2),
        ),
      ),
      child: child,
    );
  }
}
