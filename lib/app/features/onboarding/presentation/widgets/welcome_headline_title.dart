import 'package:aqar360/app/features/onboarding/presentation/widgets/head_line_text_widget.dart';
import 'package:flutter/material.dart';

class WelcomeHeadlineTitle extends StatelessWidget {
  final String title1;
  final String title2;

  const WelcomeHeadlineTitle({
    super.key,
    required this.title1,
    required this.title2,
  });
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _QuarterArchPainter(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: HeadlineTextWidget(title1: title1, title2: title2),
      ),
    );
  }
}

class _QuarterArchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF8888FF).withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width * 0.8, 0)
      ..lineTo(size.width * 0.85, 0)
      ..quadraticBezierTo(
        size.width,
        size.height * .06,
        size.width,
        size.height * .44,
      )
      ..lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
