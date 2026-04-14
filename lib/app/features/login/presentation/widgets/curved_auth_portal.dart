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
    final resolvedHeight = height ?? MediaQuery.sizeOf(context).height * 0.72 - margin;
    return Container(
      height: resolvedHeight,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        border: const Border(
          top: BorderSide(
            color: Color.fromARGB(255, 26, 111, 238),
            width: 3,
          ),
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
