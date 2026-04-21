import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/usecases/typewriter_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadlineTextWidget extends StatelessWidget {
  final String title1;
  final String title2;
  final Color? colorT1;
  final double fontSize;
  const HeadlineTextWidget({
    super.key,
    required this.title1,
    required this.title2,
    this.fontSize = 65,
    this.colorT1 = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: .start,
      children: [
        TypewriterText(
          text: title1,
          style: GoogleFonts.cairo(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,

            color: colorT1,
            height: 1.2,
          ),
        ),
        SizedBox(height: 8),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.buttonBlue, AppColors.brightCyan],
          ).createShader(bounds),
          child: TypewriterText(
            text: title2,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoKufiArabic(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
