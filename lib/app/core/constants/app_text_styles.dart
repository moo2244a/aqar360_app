import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aqar360/app/core/constants/app_colors.dart';

class AppTextStyles {
  /// الخط الأساسي للتطبيق - نستخدم Cairo كخط افتراضي للتطبيق العربي
  static TextStyle get _baseFont => GoogleFonts.cairo();

  // ==========================================
  // Headlines - العناوين الكبيرة جداً (مثل شاشات الترحيب)
  // ==========================================
  static TextStyle get headlineLarge => _baseFont.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.midnightBlue,
  );

  static TextStyle get headlineMedium => _baseFont.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.midnightBlue,
  );

  static TextStyle get headlineSmall => _baseFont.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.midnightBlue,
  );

  // ==========================================
  // Titles - عناوين الأقسام وشريط الانتقالات
  // ==========================================
  static TextStyle get titleLarge => _baseFont.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static TextStyle get titleMedium => _baseFont.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle get titleSmall => _baseFont.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  // ==========================================
  // Body - النصوص العادية والوصف
  // ==========================================

  /// النص العادي الأساسي
  static TextStyle get bodyLarge => _baseFont.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black.withValues(alpha: 0.8), // لون مريح للعين
  );

  /// النص العادي الثانوي (مثل الوصف الفرعي)
  static TextStyle get bodyMedium => _baseFont.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  /// النصوص الصغيرة جداً (مثل الملاحظات أو التاريخ)
  static TextStyle get bodySmall => _baseFont.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // ==========================================
  // Labels & Buttons - الأزرار واليافطات
  // ==========================================

  /// نصوص الأزرار الكبيرة
  static TextStyle get buttonTextLarge => _baseFont.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  /// نصوص الأزرار الصغيرة
  static TextStyle get buttonTextSmall => _baseFont.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  /// الروابط أو النصوص القابلة للضغط
  static TextStyle get textLink => _baseFont.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.buttonBlue,
    decoration: TextDecoration.underline,
  );
}
