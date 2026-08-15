import 'package:flutter/material.dart';
import '../widgets/scroll_reveal.dart';
import 'package:animations/animations.dart';
import 'package:get/get.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/custom_card.dart';
import '../widgets/section_header.dart';
import 'project_details_page.dart';
import '../controllers/projects_controller.dart';
import '../routes/app_routes.dart';

class ProjectsSection extends GetView<ProjectsController> {
  const ProjectsSection({super.key});

  static const int _initialLimit = 3;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final totalProjects = controller.projects.length;
      final displayCount = _initialLimit < totalProjects ? _initialLimit : totalProjects;
      final hasMore = totalProjects > _initialLimit;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(hasMore),
            const SizedBox(height: 40),
            LayoutBuilder(
              builder: (context, constraints) {
                final double maxWidth = constraints.maxWidth;
                final int columns = maxWidth < 650
                    ? 1
                    : (maxWidth < 1000 ? 2 : 3);
                const double spacing = 24.0;
                final double cardWidth =
                    (maxWidth - (columns - 1) * spacing) / columns;

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
          ],
        ),
      );
    });
  }

  Widget _buildHeader(bool showExploreAll) {
    return SectionHeader(
      title: "Projects",
      subtitle: "Portfolio",
      index: "05",
      trailing: showExploreAll
          ? TextButton(
              onPressed: () {
                Get.toNamed(Routes.PROJECTS);
              },
              style: TextButton.styleFrom(
                foregroundColor: ThemeConfig.primary,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Explore All",
                    style: TextStyle(
                      fontFamily: "JetBrains Mono",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    ProjectData project,
    int index,
  ) {
    return ScrollReveal(
      direction: RevealDirection.up,
      delay: Duration(milliseconds: index * 100),
      child: OpenContainer(
        transitionType: ContainerTransitionType.fade,
        openBuilder: (context, _) => ProjectDetailsPage(project: project),
        closedElevation: 0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        closedColor: Colors.transparent,
        openColor: ThemeConfig.background,
        middleColor: ThemeConfig.background,
        closedBuilder: (context, openContainer) {
          return CustomCard(
            glowColor: ThemeConfig.primary,
            onTap: openContainer,
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Aspect Ratio Video Image Frame (Clipped top rounded corners)
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            project.imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: ThemeConfig.surfaceContainerHigh,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: ThemeConfig.primary,
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
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
                                color: ThemeConfig.background.withValues(alpha: 0.8),
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
                  padding: MediaQuery.of(context).size.width < 650
                      ? const EdgeInsets.symmetric(horizontal: 20, vertical: 24)
                      : const EdgeInsets.all(24.0),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: ThemeConfig.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: ThemeConfig.primary.withValues(alpha: 0.2),
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
                      // Tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: ThemeConfig.outlineVariant.withValues(alpha:
                                  0.5,
                                ),
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
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton.icon(
                            onPressed: openContainer,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: ThemeConfig.primary,
                              side: BorderSide(color: ThemeConfig.primary.withValues(alpha: 0.5), width: 1),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            icon: const Icon(Icons.arrow_forward_rounded, size: 14),
                            label: const Text(
                              "VIEW DETAILS",
                              style: TextStyle(
                                fontFamily: "JetBrains Mono",
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
