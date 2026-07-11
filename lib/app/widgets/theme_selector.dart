import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../data/theme_config.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final currentTheme = themeController.currentTheme;

      IconData getThemeIcon(AppThemeType type) {
        switch (type) {
          case AppThemeType.aquaCyber:
            return Icons.terminal_rounded;
          case AppThemeType.orangeGreen:
            return Icons.nature_people_rounded;
          case AppThemeType.retroGold:
            return Icons.auto_awesome_rounded;
          case AppThemeType.greenWhite:
            return Icons.palette_rounded;
          case AppThemeType.blackWhite:
            return Icons.contrast_rounded;
        }
      }

      String getThemeName(AppThemeType type) {
        switch (type) {
          case AppThemeType.aquaCyber:
            return "Aqua Cyber";
          case AppThemeType.orangeGreen:
            return "Orange Green";
          case AppThemeType.retroGold:
            return "Retro Gold";
          case AppThemeType.greenWhite:
            return "Green White";
          case AppThemeType.blackWhite:
            return "Black & White";
        }
      }

      return PopupMenuButton<AppThemeType>(
        tooltip: "Change Theme",
        initialValue: currentTheme,
        onSelected: (AppThemeType type) {
          themeController.setTheme(type);
        },
        offset: const Offset(0, 48),
        color: ThemeConfig.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: ThemeConfig.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: ThemeConfig.outlineVariant.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: ThemeConfig.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                getThemeIcon(currentTheme),
                color: ThemeConfig.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                getThemeName(currentTheme),
                style: TextStyle(
                  color: ThemeConfig.textPrimary,
                  fontFamily: "JetBrains Mono",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_drop_down_rounded,
                color: ThemeConfig.textSecondary,
                size: 18,
              ),
            ],
          ),
        ),
        itemBuilder: (BuildContext context) {
          return AppThemeType.values.map((AppThemeType type) {
            final isSelected = type == currentTheme;
            final colors = _getThemePreviewColors(type);

            return PopupMenuItem<AppThemeType>(
              value: type,
              child: Row(
                children: [
                  Icon(
                    getThemeIcon(type),
                    color: isSelected ? ThemeConfig.primary : ThemeConfig.textSecondary,
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      getThemeName(type),
                      style: TextStyle(
                        color: isSelected ? ThemeConfig.primary : ThemeConfig.textPrimary,
                        fontFamily: "JetBrains Mono",
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Theme color circles preview
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: colors.map((color) {
                      return Container(
                        margin: const EdgeInsets.only(left: 4),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black26,
                            width: 0.5,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }).toList();
        },
      );
    });
  }

  List<Color> _getThemePreviewColors(AppThemeType type) {
    switch (type) {
      case AppThemeType.aquaCyber:
        return [const Color(0xFF131313), const Color(0xFF57F1DB)];
      case AppThemeType.orangeGreen:
        return [const Color(0xFF0E1310), const Color(0xFFFF9F43)];
      case AppThemeType.retroGold:
        return [const Color(0xFF0D0D0C), const Color(0xFFD4AF37)];
      case AppThemeType.greenWhite:
        return [const Color(0xFFF4F7F5), const Color(0xFF10B981)];
      case AppThemeType.blackWhite:
        return [const Color(0xFF000000), const Color(0xFFFFFFFF)];
    }
  }
}
