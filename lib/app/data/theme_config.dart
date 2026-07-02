import 'package:flutter/material.dart';

class ThemeConfig {
  // Theme Colors from HTML Config
  static const Color background = Color(0xFF131313); 
  static const Color surface = Color(0xFF131313);
  static const Color surfaceContainerLow = Color(0xFF1C1B1B);    // Card backgrounds
  static const Color surfaceContainerHigh = Color(0xFF2A2A2A);   // Inner content boxes
  static const Color surfaceContainerLowest = Color(0xFF0E0E0E); // Stats lower cards
  
  static const Color primary = Color(0xFF57F1DB);   // Bright Aqua-Teal
  static const Color onPrimary = Color(0xFF003731);
  static const Color secondary = Color(0xFFC6C6C7); 
  
  static const Color textPrimary = Color(0xFFE5E2E1);   // on-surface
  static const Color textSecondary = Color(0xFFBACAC5); // on-surface-variant
  static const Color textMuted = Color(0xFF737373);     // muted-gray
  static const Color darkGray = Color(0xFF525252);
  
  static const Color outline = Color(0xFF859490);
  static const Color outlineVariant = Color(0xFF3C4A46);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF2DD4BF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Font Family Fallback
  static const String fontFamily = 'Be Vietnam Pro';

  // Text Styles matching HTML config font sizes and weights
  static TextStyle get h1 => const TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: textPrimary,
    letterSpacing: -1,
    height: 1.1,
  );

  static TextStyle get h2 => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static TextStyle get h3 => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle get body => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.6,
  );

  static TextStyle get bodyLarge => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.6,
  );

  static TextStyle get bodyBold => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: textPrimary,
  );

  static TextStyle get caption => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textMuted,
    letterSpacing: 0.5,
  );
}
