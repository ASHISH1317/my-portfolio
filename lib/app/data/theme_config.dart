import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class ThemeConfig {
  static ThemeColors get colors {
    // If not registered yet, register a fallback
    if (!Get.isRegistered<ThemeController>()) {
      Get.put(ThemeController());
    }
    return Get.find<ThemeController>().currentColors;
  }

  // Dynamic Theme Colors
  static Color get background => colors.background;
  static Color get surface => colors.surface;
  static Color get surfaceContainerLow => colors.surfaceContainerLow;
  static Color get surfaceContainerHigh => colors.surfaceContainerHigh;
  static Color get surfaceContainerLowest => colors.surfaceContainerLowest;
  
  static Color get primary => colors.primary;
  static Color get onPrimary => colors.onPrimary;
  static Color get secondary => colors.secondary;
  
  static Color get textPrimary => colors.textPrimary;
  static Color get textSecondary => colors.textSecondary;
  static Color get textMuted => colors.textMuted;
  static Color get darkGray => colors.darkGray;
  
  static Color get outline => colors.outline;
  static Color get outlineVariant => colors.outlineVariant;

  // Gradients
  static LinearGradient get primaryGradient => colors.primaryGradient;

  // Font Family Fallback
  static const String fontFamily = 'Be Vietnam Pro';

  // Text Styles matching HTML config font sizes and weights
  static TextStyle get h1 => TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: textPrimary,
    letterSpacing: -1,
    height: 1.1,
  );

  static TextStyle get h2 => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static TextStyle get h3 => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle get body => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.6,
  );

  static TextStyle get bodyLarge => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.6,
  );

  static TextStyle get bodyBold => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: textPrimary,
  );

  static TextStyle get caption => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textMuted,
    letterSpacing: 0.5,
  );
}
