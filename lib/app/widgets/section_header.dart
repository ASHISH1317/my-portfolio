import 'package:flutter/material.dart';
import '../data/theme_config.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String index;

  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.index = "00",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Styled Keyboard Shortcut Hint Chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: ThemeConfig.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: ThemeConfig.primary.withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.keyboard,
                    size: 13,
                    color: ThemeConfig.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    index,
                    style: TextStyle(
                      fontFamily: "JetBrains Mono",
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: ThemeConfig.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Uppercase subtitle tagline
            Text(
              subtitle.toUpperCase(),
              style: TextStyle(
                fontFamily: ThemeConfig.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: ThemeConfig.textSecondary.withValues(alpha: 0.8),
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Title text using ShaderMask for gradient effect
        ShaderMask(
          shaderCallback: (bounds) => ThemeConfig.primaryGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            title,
            style: ThemeConfig.h2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Premium accent divider line
        Row(
          children: [
            Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                gradient: ThemeConfig.primaryGradient,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: ThemeConfig.primary.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 6,
              height: 4,
              decoration: BoxDecoration(
                color: ThemeConfig.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            // Long thin fading line
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ThemeConfig.primary.withOpacity(0.25),
                      ThemeConfig.primary.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
