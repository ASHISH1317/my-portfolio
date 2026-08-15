import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/theme_selector.dart';
import '../widgets/smooth_scroll_wrapper.dart';
import '../widgets/custom_card.dart';
import '../routes/app_routes.dart';
import '../controllers/all_projects_controller.dart';
import 'project_details_page.dart';

class AllProjectsPage extends GetView<AllProjectsController> {
  const AllProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;

    return Obx(() {
      return Scaffold(
        backgroundColor: ThemeConfig.background,
        body: Stack(
          children: [
            // Background decorations (Subtle ambient glows, same as details page)
            Positioned(
              top: -200,
              left: -200,
              child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ThemeConfig.primary.withValues(alpha: 0.04),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              right: -200,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ThemeConfig.primary.withValues(alpha: 0.02),
                ),
              ),
            ),

            // Scrollable Content
            Positioned.fill(
              child: SmoothScrollWrapper(
                controller: controller.scrollController,
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1280),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16.0 : 24.0,
                        vertical: 30.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 70), // Clear sticky app bar space

                          // Page Title & Subtitle inside scroll view
                          _buildPageHeader(context, isMobile),
                          const SizedBox(height: 32),

                          // Search and Filter widgets
                          _buildSearchAndFilters(context, isMobile),
                          const SizedBox(height: 40),

                          // Projects Grid
                          Obx(() {
                            final filtered = controller.filteredProjects;
                            if (filtered.isEmpty) {
                              return _buildEmptyState();
                            }
                            return LayoutBuilder(
                              builder: (context, constraints) {
                                final double maxWidth = constraints.maxWidth;
                                final int columns = maxWidth < 650
                                    ? 1
                                    : (maxWidth < 1000 ? 2 : 3);
                                const double spacing = 24.0;
                                final double cardWidth =
                                    (maxWidth - (columns - 1) * spacing) / columns;

                                return SizedBox(
                                  width: maxWidth,
                                  child: Wrap(
                                    spacing: spacing,
                                    runSpacing: spacing,
                                    children: List.generate(filtered.length, (index) {
                                      final project = filtered[index];
                                      return SizedBox(
                                        width: cardWidth,
                                        child: _buildProjectCard(context, project, index),
                                      );
                                    }),
                                  ),
                                );
                              },
                            );
                          }),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Sleek Sticky App Bar (same style as details page, with scroll search)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildStickyAppBar(context, isMobile),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildStickyAppBar(BuildContext context, bool isMobile) {
    return Obx(() {
      final double opacity = controller.scrollOpacity.value;

      return ClipRect(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: ThemeConfig.background.withValues(alpha: 0.85 * opacity),
            border: Border(
              bottom: BorderSide(
                color: ThemeConfig.outlineVariant.withValues(alpha: 0.15 * opacity),
                width: 1,
              ),
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 12 * opacity,
              sigmaY: 12 * opacity,
            ),
            child: SafeArea(
              bottom: false,
              child: SizedBox(
                height: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Center-aligned Pinned Title
                    Opacity(
                      opacity: opacity,
                      child: Text(
                        "All Projects",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 15 : 18,
                          fontWeight: FontWeight.bold,
                          color: ThemeConfig.textPrimary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    // Left-aligned circular Back Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            if (Navigator.of(context).canPop()) {
                              Get.back();
                            } else {
                              Get.offAllNamed(Routes.HOME);
                            }
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: ThemeConfig.background.withValues(alpha: 0.8 * (1 - opacity)),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ThemeConfig.outlineVariant.withValues(
                                  alpha: 0.3 * (1 - opacity) + 0.1 * opacity,
                                ),
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: ThemeConfig.primary,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Right-aligned Theme Selector
                    Align(
                      alignment: Alignment.centerRight,
                      child: const ThemeSelector(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildPageHeader(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "All Projects",
          style: TextStyle(
            color: ThemeConfig.textPrimary,
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "EXPLORE THE FULL ARCHIVE",
          style: TextStyle(
            color: ThemeConfig.primary,
            fontFamily: "JetBrains Mono",
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Input
        Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: TextField(
            controller: controller.searchController,
            onChanged: controller.setSearchQuery,
            style: TextStyle(color: ThemeConfig.textPrimary, fontSize: 14),
            decoration: InputDecoration(
              hintText: "Search projects, stack, tags...",
              hintStyle: TextStyle(color: ThemeConfig.textMuted, fontSize: 14),
              prefixIcon: Icon(Icons.search_rounded, color: ThemeConfig.primary, size: 20),
              filled: true,
              fillColor: ThemeConfig.surfaceContainerLow.withValues(alpha: 0.6),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: ThemeConfig.outlineVariant.withValues(alpha: 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ThemeConfig.primary, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Tags Filter List (Wrap Grid layout - Scrollable Row on Mobile)
        Obx(() {
          final chips = controller.tagsList.map((tag) {
            final isSelected = controller.selectedTag.value == tag;

            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => controller.selectTag(tag),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? ThemeConfig.primary 
                        : ThemeConfig.surfaceContainerLow.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? ThemeConfig.primary
                          : ThemeConfig.outlineVariant.withValues(alpha: 0.2),
                    ),
                    boxShadow: isSelected ? [
                      BoxShadow(
                        color: ThemeConfig.primary.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ] : null,
                  ),
                  child: Text(
                    tag.toUpperCase(),
                    style: TextStyle(
                      fontFamily: "JetBrains Mono",
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? ThemeConfig.onPrimary : ThemeConfig.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            );
          }).toList();

          if (isMobile) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: chips.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final widget = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(right: idx == chips.length - 1 ? 0 : 10),
                    child: widget,
                  );
                }).toList(),
              ),
            );
          } else {
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: chips,
            );
          }
        }),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: ThemeConfig.textMuted,
            ),
            const SizedBox(height: 20),
            Text(
              "No projects match your search criteria.",
              style: TextStyle(
                color: ThemeConfig.textSecondary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Try clearing filters or queries to see all archive items.",
              style: TextStyle(
                color: ThemeConfig.textMuted,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    ProjectData project,
    int index,
  ) {
    return OpenContainer(
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
                              color: ThemeConfig.outlineVariant.withValues(alpha: 0.5),
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
    );
  }
}
