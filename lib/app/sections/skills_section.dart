import 'package:flutter/material.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  int _activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;
    
    final activeCategory = PortfolioData.skills[_activeTabIndex];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 48),
          
          // Skill Tabs
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(PortfolioData.skills.length, (index) {
              final cat = PortfolioData.skills[index];
              final bool isActive = _activeTabIndex == index;
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => setState(() => _activeTabIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: isActive ? ThemeConfig.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isActive ? Colors.transparent : ThemeConfig.outlineVariant.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      cat.name,
                      style: TextStyle(
                        color: isActive ? ThemeConfig.onPrimary : ThemeConfig.textSecondary,
                        fontSize: 14,
                        fontFamily: "JetBrains Mono",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 32),

          // Skill Content Grid
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 24 : 48),
            decoration: BoxDecoration(
              color: ThemeConfig.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: ThemeConfig.outlineVariant.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: activeCategory.skills.map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: ThemeConfig.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: ThemeConfig.outlineVariant.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    skill.name,
                    style: const TextStyle(
                      color: ThemeConfig.textPrimary,
                      fontSize: 14,
                      fontFamily: "JetBrains Mono",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 48),

          // Skill Stats Grid (flat blocks)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : (width < 1000 ? 3 : 5),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isMobile ? 1.4 : 1.3,
            ),
            itemCount: PortfolioData.skills.length,
            itemBuilder: (context, index) {
              final cat = PortfolioData.skills[index];
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ThemeConfig.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: ThemeConfig.outlineVariant.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${cat.skills.length}",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: ThemeConfig.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cat.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontFamily: "JetBrains Mono",
                        color: ThemeConfig.textSecondary,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
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
              "02",
              style: TextStyle(
                fontFamily: "monospace",
                color: ThemeConfig.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "SKILLS & TECH",
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
          "Skills & Tech",
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
}
