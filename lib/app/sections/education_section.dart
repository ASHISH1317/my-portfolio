import 'package:flutter/material.dart';
import '../widgets/scroll_reveal.dart';
import 'package:get/get.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/custom_card.dart';
import '../widgets/section_header.dart';
import '../controllers/education_controller.dart';

class EducationSection extends GetView<EducationController> {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 40),
          ...controller.education.asMap().entries.map((entry) {
            final index = entry.key;
            final edu = entry.value;
            return ScrollReveal(
              direction: RevealDirection.up,
              delay: Duration(milliseconds: 150 + index * 100),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: _buildEducationCard(edu, isMobile: isMobile),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SectionHeader(
      title: "Education",
      subtitle: "Education",
      index: "06",
    );
  }

  Widget _buildEducationCard(EducationData edu, {bool isMobile = false}) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      child: CustomCard(
        glowColor: ThemeConfig.primary,
        padding: isMobile
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 24)
            : const EdgeInsets.all(32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: ThemeConfig.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.school_outlined,
                color: ThemeConfig.primary,
                size: 32,
              ),
            ),
            const SizedBox(width: 24),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    edu.degree,
                    style: ThemeConfig.h3.copyWith(
                      fontSize: 20,
                      color: ThemeConfig.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    edu.institution,
                    style: TextStyle(
                      color: ThemeConfig.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 24,
                    runSpacing: 8,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.calendar_month_outlined, color: ThemeConfig.textSecondary, size: 16),
                          const SizedBox(width: 8),
                          Text(edu.period, style: TextStyle(color: ThemeConfig.textSecondary, fontSize: 14)),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.grade_outlined, color: ThemeConfig.textSecondary, size: 16),
                          const SizedBox(width: 8),
                          Text(edu.grade, style: TextStyle(color: ThemeConfig.textSecondary, fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
