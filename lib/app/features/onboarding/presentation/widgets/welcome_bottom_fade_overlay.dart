import 'package:flutter/material.dart';

class WelcomeBottomFadeOverlay extends StatelessWidget {
  const WelcomeBottomFadeOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: size.height / 2,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFF0F0F23),
                  Color(0xF20F0F23), // alpha 0.95
                  Color(0x330F0F23), // alpha 0.2
                ],
                stops: [0.0, 0.8, 1.0],
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 100,
          left: 0,
          right: 0,
          child: Container(
            height: size.height / 2,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFF0F0F23), // alpha 1.0
                  Color(0xFF0F0F23), // alpha 1.0
                  Color(0x000F0F23), // alpha 0.0
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
