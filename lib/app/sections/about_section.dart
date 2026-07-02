import 'package:flutter/material.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/custom_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 900;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 40),
          isMobile
              ? Column(
                  children: [
                    _buildBio(),
                    const SizedBox(height: 48),
                    _buildHighlightsGrid(isMobile: true),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 11,
                      child: _buildBio(),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      flex: 9,
                      child: _buildHighlightsGrid(isMobile: false),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "01",
              style: TextStyle(
                fontFamily: "monospace",
                color: ThemeConfig.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "ABOUT ME",
              style: TextStyle(
                color: ThemeConfig.primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "My Journey & Core Focus",
          style: ThemeConfig.h2,
        ),
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: ThemeConfig.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildBio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PortfolioData.aboutText1,
          style: ThemeConfig.bodyLarge.copyWith(
            fontSize: 17,
            height: 1.7,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          PortfolioData.aboutText2,
          style: ThemeConfig.body.copyWith(
            fontSize: 15,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          PortfolioData.aboutText3,
          style: ThemeConfig.body.copyWith(
            fontSize: 15,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 32),
        // Skill Tags
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            "Flutter",
            "Dart",
            "Firebase",
            "REST APIs",
            "GetX",
            "Riverpod",
          ].map((tag) => _buildTag(tag)).toList(),
        ),
      ],
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeConfig.textMuted.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: ThemeConfig.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildHighlightsGrid({required bool isMobile}) {
    final highlights = [
      {
        "title": "Cross-Platform",
        "desc": "Building seamless apps for iOS & Android with a single Flutter codebase.",
        "icon": Icons.tablet_android_rounded,
      },
      {
        "title": "Clean Architecture",
        "desc": "Writing scalable, maintainable code with SOLID principles and best practices.",
        "icon": Icons.code_rounded,
      },
      {
        "title": "Performance",
        "desc": "Optimizing app performance with efficient state management and caching strategies.",
        "icon": Icons.bolt_rounded,
      },
      {
        "title": "Team Leadership",
        "desc": "Leading dev teams, mentoring juniors, and driving project delivery as Tech Lead.",
        "icon": Icons.groups_rounded,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: isMobile ? 1.8 : 0.95,
      ),
      itemCount: highlights.length,
      itemBuilder: (context, index) {
        final hl = highlights[index];
        return CustomCard(
          glowColor: ThemeConfig.primary,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  hl["icon"] as IconData,
                  color: ThemeConfig.primary,
                  size: 28,
                ),
                const SizedBox(height: 12),
                Text(
                  hl["title"] as String,
                  style: ThemeConfig.h3.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  hl["desc"] as String,
                  style: ThemeConfig.body.copyWith(
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
