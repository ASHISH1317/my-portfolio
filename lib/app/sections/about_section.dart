import 'package:flutter/material.dart';
import '../widgets/scroll_reveal.dart';
import 'package:get/get.dart';
import '../data/theme_config.dart';
import '../widgets/section_header.dart';
import '../controllers/about_controller.dart';
import '../widgets/tilt_card.dart';

class AboutSection extends GetView<AboutController> {
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
    return SectionHeader(
      title: "About Me",
      subtitle: "Profile",
      index: "01",
    );
  }

  Widget _buildBio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScrollReveal(
          direction: RevealDirection.up,
          delay: Duration.zero,
          child: Text(
            controller.aboutText1,
            style: ThemeConfig.bodyLarge.copyWith(
              fontSize: 17,
              height: 1.7,
              color: ThemeConfig.textPrimary.withValues(alpha: 0.9),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ScrollReveal(
          direction: RevealDirection.up,
          delay: const Duration(milliseconds: 100),
          child: Text(
            controller.aboutText2,
            style: ThemeConfig.body.copyWith(
              fontSize: 15,
              height: 1.7,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ScrollReveal(
          direction: RevealDirection.up,
          delay: const Duration(milliseconds: 200),
          child: Text(
            controller.aboutText3,
            style: ThemeConfig.body.copyWith(
              fontSize: 15,
              height: 1.7,
            ),
          ),
        ),
        const SizedBox(height: 32),
        // Skill Tags
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: controller.tags.asMap().entries.map((entry) {
            final idx = entry.key;
            final tag = entry.value;
            return ScrollReveal(
              direction: RevealDirection.none,
              scale: 0.8,
              delay: Duration(milliseconds: 300 + idx * 25),
              curve: Curves.easeOutBack,
              child: _HoverTag(tag: tag),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildHighlightsGrid({required bool isMobile}) {
    final highlights = controller.highlights;

    Widget buildCard(Map<String, dynamic> hl, int index) {
      return ScrollReveal(
        direction: RevealDirection.up,
        delay: Duration(milliseconds: 150 + index * 80),
        child: _HighlightCard(highlight: hl, index: index),
      );
    }

    if (isMobile) {
      return Column(
        children: highlights.asMap().entries.map((entry) {
          final idx = entry.key;
          final hl = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: buildCard(hl, idx),
          );
        }).toList(),
      );
    } else {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildCard(highlights[0], 0)),
              const SizedBox(width: 16),
              Expanded(child: buildCard(highlights[1], 1)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildCard(highlights[2], 2)),
              const SizedBox(width: 16),
              Expanded(child: buildCard(highlights[3], 3)),
            ],
          ),
        ],
      );
    }
  }
}

class _HighlightCard extends StatefulWidget {
  final Map<String, dynamic> highlight;
  final int index;

  const _HighlightCard({
    required this.highlight,
    required this.index,
  });

  @override
  State<_HighlightCard> createState() => _HighlightCardState();
}

class _HighlightCardState extends State<_HighlightCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double radius = 20.0;

    return TiltCard(
      borderRadius: BorderRadius.circular(radius),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(1.5), // Outer border spacing
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: _isHovered
                ? LinearGradient(
                    colors: [
                      ThemeConfig.primary,
                      ThemeConfig.primary.withValues(alpha: 0.3),
                      ThemeConfig.outlineVariant.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [
                      ThemeConfig.outline.withValues(alpha: 0.15),
                      ThemeConfig.outline.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius - 1.5),
            child: Container(
              color: ThemeConfig.surfaceContainerLow,
              child: Stack(
                children: [
                  // Subtle Mesh Radial Glow in top right corner
                  Positioned(
                    top: -40,
                    right: -40,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 350),
                      opacity: _isHovered ? 0.22 : 0.05,
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              ThemeConfig.primary,
                              ThemeConfig.primary.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Card Main Body Content
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Animated Glowy Icon Backdrop
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _isHovered
                                ? ThemeConfig.primary.withValues(alpha: 0.12)
                                : ThemeConfig.surfaceContainerHigh.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: _isHovered
                                  ? ThemeConfig.primary.withValues(alpha: 0.3)
                                  : ThemeConfig.outline.withValues(alpha: 0.08),
                              width: 1,
                            ),
                          ),
                          child: AnimatedScale(
                            scale: _isHovered ? 1.12 : 1.0,
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeOutBack,
                            child: AnimatedRotation(
                              turns: _isHovered ? 0.02 : 0.0,
                              duration: const Duration(milliseconds: 350),
                              child: Icon(
                                widget.highlight["icon"] as IconData,
                                color: _isHovered ? ThemeConfig.primary : ThemeConfig.textPrimary.withValues(alpha: 0.8),
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Highlight Title
                        Text(
                          widget.highlight["title"] as String,
                          style: ThemeConfig.h3.copyWith(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w700,
                            color: ThemeConfig.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Highlight Description
                        Text(
                          widget.highlight["desc"] as String,
                          style: ThemeConfig.body.copyWith(
                            fontSize: 13,
                            height: 1.55,
                            color: ThemeConfig.textSecondary.withValues(alpha: 0.95),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HoverTag extends StatefulWidget {
  final String tag;
  const _HoverTag({required this.tag});

  @override
  State<_HoverTag> createState() => _HoverTagState();
}

class _HoverTagState extends State<_HoverTag> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? ThemeConfig.primary.withValues(alpha: 0.08)
                : Colors.white.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? ThemeConfig.primary.withValues(alpha: 0.6)
                  : ThemeConfig.textMuted.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: ThemeConfig.primary.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          child: Text(
            widget.tag,
            style: TextStyle(
              color: _isHovered ? ThemeConfig.primary : ThemeConfig.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
