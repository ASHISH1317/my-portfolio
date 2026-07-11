import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/custom_card.dart';
import '../widgets/section_header.dart';
import '../controllers/experience_controller.dart';

class ExperienceSection extends GetView<ExperienceController> {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 60),
          _buildTimeline(context, isMobile),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SectionHeader(
      title: "Experience",
      subtitle: "Work History",
      index: "03",
    );
  }

  Widget _buildTimeline(BuildContext context, bool isMobile) {
    final list = controller.experiences;
    final leftPadding = isMobile ? 12.0 : 28.0;

    return Stack(
      children: [
        // Timeline connection line
        Positioned(
          left: leftPadding + 11.0, // align with center of 24px indicator circle (12px)
          top: 24,
          bottom: 24,
          child: Container(
            width: 2,
            color: ThemeConfig.primary.withOpacity(0.15),
          ),
        ),
        // Timeline Items
        Column(
          children: list.map((exp) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline dot
                  Padding(
                    padding: EdgeInsets.only(left: leftPadding, top: 4),
                    child: exp.isCurrent
                        ? const PulsingDot()
                        : Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: ThemeConfig.background,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ThemeConfig.outlineVariant,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: ThemeConfig.textMuted,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                  ),
                  SizedBox(width: isMobile ? 16 : 32),
                  // Experience Card Info
                  Expanded(
                    child: CustomCard(
                      glowColor: exp.isCurrent ? ThemeConfig.primary : Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isMobile)
                              _buildMobileCardHeader(exp)
                            else
                              _buildDesktopCardHeader(exp),
                            const SizedBox(height: 20),
                            // Bullet Points
                            ...exp.bullets.map((bullet) {
                              final IconData icon = exp.bulletIcon == "terminal"
                                  ? Icons.terminal_rounded
                                  : Icons.check_circle_rounded;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: Icon(
                                        icon,
                                        color: ThemeConfig.primary,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        bullet,
                                        style: ThemeConfig.body.copyWith(
                                          fontSize: 14,
                                          height: 1.5,
                                          color: ThemeConfig.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            // Tags Footer
                            if (exp.tags.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: ThemeConfig.outlineVariant,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.only(top: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "KEY CONTRIBUTIONS & TECH",
                                      style: TextStyle(
                                        color: ThemeConfig.textMuted,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: exp.tags.map((tag) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: ThemeConfig.outlineVariant.withValues(alpha: 0.1),
                                            border: Border.all(
                                              color: ThemeConfig.outlineVariant,
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            tag,
                                            style: TextStyle(
                                              color: ThemeConfig.textSecondary,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMobileCardHeader(ExperienceData exp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exp.role,
          style: ThemeConfig.h3.copyWith(
            fontSize: 18,
            color: ThemeConfig.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Text(
              exp.company,
              style: TextStyle(
                color: ThemeConfig.primary,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "|",
              style: TextStyle(color: ThemeConfig.textMuted),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.location_on_outlined,
              color: ThemeConfig.textSecondary,
              size: 13,
            ),
            const SizedBox(width: 2),
            Text(
              exp.location.split(',').first, // Shorten Surat, Gujarat, India to Surat
              style: TextStyle(
                color: ThemeConfig.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              exp.period,
              style: TextStyle(
                color: ThemeConfig.textMuted,
                fontSize: 12,
              ),
            ),
            if (exp.isCurrent) _buildCurrentBadge(),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopCardHeader(ExperienceData exp) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exp.role,
                style: ThemeConfig.h3.copyWith(
                  fontSize: 22,
                  color: ThemeConfig.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Text(
                    exp.company,
                    style: TextStyle(
                      color: ThemeConfig.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    "|",
                    style: TextStyle(color: ThemeConfig.textMuted),
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    color: ThemeConfig.textSecondary,
                    size: 14,
                  ),
                  Text(
                    exp.location,
                    style: TextStyle(
                      color: ThemeConfig.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (exp.isCurrent) ...[
              _buildCurrentBadge(),
              const SizedBox(height: 6),
            ],
            Text(
              exp.period,
              style: TextStyle(
                color: ThemeConfig.textMuted,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCurrentBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: ThemeConfig.primary.withOpacity(0.1),
        border: Border.all(
          color: ThemeConfig.primary.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "Current Role",
        style: TextStyle(
          color: ThemeConfig.primary,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PulsingDot extends StatefulWidget {
  const PulsingDot({super.key});

  @override
  State<PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<PulsingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: ThemeConfig.background,
        shape: BoxShape.circle,
        border: Border.all(color: ThemeConfig.primary, width: 2),
      ),
      child: Center(
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.75, end: 1.2).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          ),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: ThemeConfig.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
