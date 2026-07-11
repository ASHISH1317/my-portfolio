import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/custom_card.dart';
import '../widgets/section_header.dart';
import 'project_details_page.dart';
import '../controllers/projects_controller.dart';

class ProjectsSection extends GetView<ProjectsController> {
  const ProjectsSection({super.key});

  static const int _initialLimit = 3;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;
    final bool isTablet = width >= 700 && width < 1100;

    return Obx(() {
      final showAll = controller.showAll.value;
      final totalProjects = controller.projects.length;
      final displayCount = showAll ? totalProjects : (_initialLimit < totalProjects ? _initialLimit : totalProjects);
      final hasMore = totalProjects > _initialLimit;

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
            LayoutBuilder(
              builder: (context, constraints) {
                final double maxWidth = constraints.maxWidth;
                final int columns = maxWidth < 650 ? 1 : (maxWidth < 1000 ? 2 : 3);
                const double spacing = 24.0;
                final double cardWidth = (maxWidth - (columns - 1) * spacing) / columns;

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: List.generate(displayCount, (index) {
                    final project = controller.projects[index];
                    return SizedBox(
                      width: cardWidth,
                      child: _buildProjectCard(context, project, index),
                    );
                  }),
                );
              },
            ),
            if (hasMore && !showAll) ...[
              const SizedBox(height: 48),
              Center(
                child: OutlinedButton.icon(
                  onPressed: () {
                    controller.toggleShowAll();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: ThemeConfig.outline),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: Text(
                    "View ${totalProjects - _initialLimit} More Projects",
                    style: TextStyle(
                      color: ThemeConfig.textPrimary,
                      fontFamily: "JetBrains Mono",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  label: Icon(
                    Icons.expand_more_rounded,
                    color: ThemeConfig.textPrimary,
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildHeader() {
    return SectionHeader(
      title: "Projects",
      subtitle: "Portfolio",
      index: "04",
    );
  }

  Widget _buildProjectCard(BuildContext context, ProjectData project, int index) {
    return CustomCard(
      glowColor: ThemeConfig.primary,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProjectDetailsPage(project: project),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Aspect Ratio Video Image Frame (Clipped top rounded corners)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      project.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: ThemeConfig.surfaceContainerHigh,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: ThemeConfig.textMuted,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                  // Overlay URL link icon
                  Positioned(
                    top: 16,
                    right: 16,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: ThemeConfig.background.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.open_in_new_rounded,
                          color: ThemeConfig.textPrimary,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        project.title,
                        style: ThemeConfig.h3.copyWith(fontSize: 18),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: ThemeConfig.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: ThemeConfig.primary.withOpacity(0.2),
                        ),
                      ),
                      child: Text(
                        "FEATURED",
                        style: TextStyle(
                          color: ThemeConfig.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  project.description,
                  style: ThemeConfig.body.copyWith(
                    color: ThemeConfig.textSecondary,
                    fontSize: 14,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                // Key Highlights
                Text(
                  "KEY HIGHLIGHTS",
                  style: TextStyle(
                    color: ThemeConfig.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                ...project.keyFeatures.take(2).map((feature) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 2.0),
                          child: Icon(
                            Icons.check_circle_outline_rounded,
                            color: ThemeConfig.primary,
                            size: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: ThemeConfig.body.copyWith(
                                fontSize: 12,
                                height: 1.4,
                              ),
                              children: [
                                TextSpan(
                                  text: "${feature.title}: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: ThemeConfig.textPrimary,
                                  ),
                                ),
                                TextSpan(
                                  text: feature.description,
                                  style: TextStyle(
                                    color: ThemeConfig.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(height: 16),
                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: ThemeConfig.outlineVariant.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: ThemeConfig.textSecondary,
                          fontSize: 10,
                          fontFamily: "JetBrains Mono",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
