import 'package:flutter/material.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/custom_card.dart';
import '../widgets/section_header.dart';

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
    return const SectionHeader(
      title: "About Me",
      subtitle: "Profile",
      index: "01",
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
        "title": "Scalable Architecture",
        "desc": "Architecting clean, modular, and testable codebases utilizing SOLID principles for future-proof scalability.",
        "icon": Icons.architecture_rounded,
      },
      {
        "title": "High Performance",
        "desc": "Crafting fluid, responsive interfaces running at 60/120 FPS with highly optimized state management.",
        "icon": Icons.speed_rounded,
      },
      {
        "title": "Robust Integrations",
        "desc": "Seamlessly connecting real-time WebSockets, enterprise IoT APIs, and secure payment systems.",
        "icon": Icons.hub_rounded,
      },
      {
        "title": "Engineering Leadership",
        "desc": "Leading agile development teams, mentoring junior engineers, and driving successful App Store deliveries.",
        "icon": Icons.psychology_rounded,
      },
    ];

    Widget buildCard(Map<String, dynamic> hl) {
      return CustomCard(
        glowColor: ThemeConfig.primary,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
    }

    if (isMobile) {
      return Column(
        children: highlights.map((hl) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: buildCard(hl),
          );
        }).toList(),
      );
    } else {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildCard(highlights[0])),
              const SizedBox(width: 16),
              Expanded(child: buildCard(highlights[1])),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildCard(highlights[2])),
              const SizedBox(width: 16),
              Expanded(child: buildCard(highlights[3])),
            ],
          ),
        ],
      );
    }
  }
}
