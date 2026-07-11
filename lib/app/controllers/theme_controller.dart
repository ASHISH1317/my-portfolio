import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AppThemeType {
  aquaCyber,
  orangeGreen,
  retroGold,
  greenWhite,
  blackWhite,
}

class ThemeColors {
  final Color background;
  final Color surface;
  final Color surfaceContainerLow;
  final Color surfaceContainerHigh;
  final Color surfaceContainerLowest;
  
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color darkGray;
  
  final Color outline;
  final Color outlineVariant;
  final LinearGradient primaryGradient;

  const ThemeColors({
    required this.background,
    required this.surface,
    required this.surfaceContainerLow,
    required this.surfaceContainerHigh,
    required this.surfaceContainerLowest,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.darkGray,
    required this.outline,
    required this.outlineVariant,
    required this.primaryGradient,
  });
}

class ThemeController extends GetxController {
  final Rx<AppThemeType> rxThemeType = AppThemeType.aquaCyber.obs;

  AppThemeType get currentTheme => rxThemeType.value;

  void setTheme(AppThemeType type) {
    rxThemeType.value = type;
  }

  void cycleTheme() {
    final nextIndex = (rxThemeType.value.index + 1) % AppThemeType.values.length;
    rxThemeType.value = AppThemeType.values[nextIndex];
  }

  ThemeColors get currentColors {
    switch (rxThemeType.value) {
      case AppThemeType.aquaCyber:
        return const ThemeColors(
          background: Color(0xFF131313),
          surface: Color(0xFF131313),
          surfaceContainerLow: Color(0xFF1C1B1B),
          surfaceContainerHigh: Color(0xFF2A2A2A),
          surfaceContainerLowest: Color(0xFF0E0E0E),
          primary: Color(0xFF57F1DB),
          onPrimary: Color(0xFF003731),
          secondary: Color(0xFFC6C6C7),
          textPrimary: Color(0xFFE5E2E1),
          textSecondary: Color(0xFFBACAC5),
          textMuted: Color(0xFF737373),
          darkGray: Color(0xFF525252),
          outline: Color(0xFF859490),
          outlineVariant: Color(0xFF3C4A46),
          primaryGradient: LinearGradient(
            colors: [Color(0xFF57F1DB), Color(0xFF2DD4BF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
      case AppThemeType.orangeGreen:
        return const ThemeColors(
          background: Color(0xFF0E1310),
          surface: Color(0xFF0E1310),
          surfaceContainerLow: Color(0xFF151D19),
          surfaceContainerHigh: Color(0xFF212E27),
          surfaceContainerLowest: Color(0xFF080B09),
          primary: Color(0xFFFF9F43),
          onPrimary: Color(0xFF2C1A00),
          secondary: Color(0xFF2ED573),
          textPrimary: Color(0xFFE0E6E3),
          textSecondary: Color(0xFFB1C4BD),
          textMuted: Color(0xFF6F857D),
          darkGray: Color(0xFF465B54),
          outline: Color(0xFF7D9C90),
          outlineVariant: Color(0xFF354841),
          primaryGradient: LinearGradient(
            colors: [Color(0xFFFF9F43), Color(0xFF2ED573)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
      case AppThemeType.retroGold:
        return const ThemeColors(
          background: Color(0xFF0D0D0C),
          surface: Color(0xFF0D0D0C),
          surfaceContainerLow: Color(0xFF171715),
          surfaceContainerHigh: Color(0xFF262622),
          surfaceContainerLowest: Color(0xFF080807),
          primary: Color(0xFFD4AF37),
          onPrimary: Color(0xFF1A1300),
          secondary: Color(0xFFE6DBC4),
          textPrimary: Color(0xFFFDFBF7),
          textSecondary: Color(0xFFE0D8C3),
          textMuted: Color(0xFF968F7E),
          darkGray: Color(0xFF666155),
          outline: Color(0xFFAA9E82),
          outlineVariant: Color(0xFF4A453B),
          primaryGradient: LinearGradient(
            colors: [Color(0xFFD4AF37), Color(0xFFFFDF73)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
      case AppThemeType.greenWhite:
        return const ThemeColors(
          background: Color(0xFFF4F7F5), // Soft white-green tint
          surface: Color(0xFFF4F7F5),
          surfaceContainerLow: Color(0xFFFFFFFF),
          surfaceContainerHigh: Color(0xFFE8ECE9),
          surfaceContainerLowest: Color(0xFFDCE2DF),
          primary: Color(0xFF10B981), // Bright Emerald Green
          onPrimary: Colors.white,
          secondary: Color(0xFF2D3748),
          textPrimary: Color(0xFF1A2A22), // Very dark slate-forest text (fully visible)
          textSecondary: Color(0xFF4A5D54), // Medium forest-grey text
          textMuted: Color(0xFF758A80),
          darkGray: Color(0xFF9EAEA5),
          outline: Color(0xFFCBDAD2),
          outlineVariant: Color(0xFFB0C0B7), // Visible borders
          primaryGradient: LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF059669)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
      case AppThemeType.blackWhite:
        return const ThemeColors(
          background: Color(0xFF000000),
          surface: Color(0xFF000000),
          surfaceContainerLow: Color(0xFF0D0D0D),
          surfaceContainerHigh: Color(0xFF1E1E1E),
          surfaceContainerLowest: Color(0xFF050505),
          primary: Color(0xFFFFFFFF),
          onPrimary: Colors.black,
          secondary: Color(0xFFE0E0E0),
          textPrimary: Color(0xFFFFFFFF),
          textSecondary: Color(0xFFCCCCCC),
          textMuted: Color(0xFF777777),
          darkGray: Color(0xFF333333),
          outline: Color(0xFF555555),
          outlineVariant: Color(0xFF222222),
          primaryGradient: LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFF888888)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
    }
  }
}
