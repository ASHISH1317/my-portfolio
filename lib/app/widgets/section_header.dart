import 'package:flutter/material.dart';
import '../data/theme_config.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String index;

  SectionHeader({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Styled 2-digit index tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: ThemeConfig.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: ThemeConfig.primary.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Text(
                index,
                style: TextStyle(
                  fontFamily: ThemeConfig.fontFamily,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: ThemeConfig.primary,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Uppercase subtitle tagline
            Text(
              subtitle.toUpperCase(),
              style: TextStyle(
                fontFamily: ThemeConfig.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: ThemeConfig.textSecondary.withOpacity(0.8),
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
