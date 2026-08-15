import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/custom_card.dart';
import '../widgets/animated_section_divider.dart';
import '../widgets/smooth_scroll_wrapper.dart';
import '../widgets/theme_selector.dart';
import 'package:get/get.dart';

class ProjectDetailsPage extends StatefulWidget {
  final ProjectData project;

  const ProjectDetailsPage({
    super.key,
    required this.project,
  });

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _backgroundRowKey = GlobalKey();
  final GlobalKey _cleanArchRowKey = GlobalKey();
  double _scrollOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!mounted) return;
    // Calculate a continuous opacity between 0.0 and 1.0 from scrollOffset 100 to 250
    double opacity = ((_scrollController.offset - 100) / 150).clamp(0.0, 1.0);
    if (opacity != _scrollOpacity) {
      setState(() {
        _scrollOpacity = opacity;
      });
    }
  }

  Future<void> _launchUrl(String url) async {
    if (url.isEmpty) return;
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $url");
    }
  }

  void _openFullImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.85,
                    ),
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
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
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: ThemeConfig.surfaceContainerHigh,
                          child: Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              color: ThemeConfig.textMuted,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white, size: 32),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;

    return Obx(() => Scaffold(
      backgroundColor: ThemeConfig.background,
      body: Stack(
        children: [
          // Background decorations (Subtle ambient glows)
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

          // Scrollable content
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: SmoothScrollWrapper(
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 1280),
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 16.0 : 24.0,
                            vertical: 40.0,
                          ),
                          child: Builder(
                            builder: (context) {
                              final List<Widget> childrenList = [];
                              childrenList.add(const SizedBox(height: 40));
                              childrenList.add(_buildHeroSection(isMobile));

                              if (widget.project.backgroundStory.isNotEmpty || widget.project.keyFeatures.isNotEmpty) {
                                childrenList.add(const SizedBox(height: 40));
                                childrenList.add(AnimatedSectionDivider());
                                childrenList.add(const SizedBox(height: 40));
                                childrenList.add(_buildBackgroundAndFeatures(isMobile));
                              }

                              if (widget.project.techStack.isNotEmpty) {
                                childrenList.add(const SizedBox(height: 40));
                                childrenList.add(AnimatedSectionDivider());
                                childrenList.add(const SizedBox(height: 40));
                                childrenList.add(_buildTechStackSection(width));
                              }

                              if (widget.project.codeSnippet.isNotEmpty) {
                                childrenList.add(const SizedBox(height: 40));
                                childrenList.add(AnimatedSectionDivider());
                                childrenList.add(const SizedBox(height: 40));
                                childrenList.add(_buildCleanArchitectureSection(isMobile));
                              }

                              if (widget.project.screenshots.isNotEmpty) {
                                childrenList.add(const SizedBox(height: 40));
                                childrenList.add(AnimatedSectionDivider());
                                childrenList.add(const SizedBox(height: 40));
                                childrenList.add(_buildScreenshotsSection(isMobile));
                              }

                              if (widget.project.integrations.isNotEmpty) {
                                childrenList.add(const SizedBox(height: 40));
                                childrenList.add(AnimatedSectionDivider());
                                childrenList.add(const SizedBox(height: 40));
                                childrenList.add(_buildIntegrationsSection(isMobile));
                              }

                              childrenList.add(const SizedBox(height: 80));
                              childrenList.add(_buildFooter(isMobile));

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: childrenList,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Sleek Custom Sticky App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: ThemeConfig.background.withValues(alpha: 0.85 * _scrollOpacity),
                  border: Border(
                    bottom: BorderSide(
                      color: ThemeConfig.outlineVariant.withValues(alpha: 0.15 * _scrollOpacity),
                      width: 1,
                    ),
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 12 * _scrollOpacity,
                    sigmaY: 12 * _scrollOpacity,
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: SizedBox(
                      height: 40,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Center-aligned Pinned Project Title
                          Opacity(
                            opacity: _scrollOpacity,
                            child: Text(
                              widget.project.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isMobile ? 15 : 18,
                                fontWeight: FontWeight.bold,
                                color: ThemeConfig.textPrimary,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          // Left-aligned Back Button
                          Align(
                            alignment: Alignment.centerLeft,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: ThemeConfig.background.withValues(alpha: 0.8 * (1 - _scrollOpacity)),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: ThemeConfig.outlineVariant.withValues(
                                        alpha: 0.3 * (1 - _scrollOpacity) + 0.1 * _scrollOpacity,
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
            ),
          ),
        ],
      ),
    ));
  }



  // Hero Section
  Widget _buildHeroSection(bool isMobile) {
    return Column(
      children: [
        // Tags
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: widget.project.tags.map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: ThemeConfig.primary.withValues(alpha: 0.8), width: 1),
              ),
              child: Text(
                tag.toUpperCase(),
                style: TextStyle(
                  color: ThemeConfig.primary,
                  fontFamily: "JetBrains Mono",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        // Title
        Text(
          widget.project.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 36 : 64,
            fontWeight: FontWeight.w800,
            color: ThemeConfig.textPrimary,
            letterSpacing: -1.5,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 24),
        // Description
        Container(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            widget.project.description,
            textAlign: TextAlign.center,
            style: ThemeConfig.bodyLarge.copyWith(
              color: ThemeConfig.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 40),
        // Actions
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            if (widget.project.githubUrl.isNotEmpty)
              ElevatedButton.icon(
                onPressed: () => _launchUrl(widget.project.githubUrl),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeConfig.primary,
                  foregroundColor: ThemeConfig.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.code_rounded, size: 20),
                label: const Text(
                  "View Code",
                  style: TextStyle(
                    fontFamily: "JetBrains Mono",
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            if (widget.project.playStoreUrl.isNotEmpty)
              ElevatedButton.icon(
                onPressed: () => _launchUrl(widget.project.playStoreUrl),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeConfig.primary,
                  foregroundColor: ThemeConfig.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.android_rounded, size: 20),
                label: const Text(
                  "Play Store",
                  style: TextStyle(
                    fontFamily: "JetBrains Mono",
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            if (widget.project.appStoreUrl.isNotEmpty)
              ElevatedButton.icon(
                onPressed: () => _launchUrl(widget.project.appStoreUrl),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeConfig.primary,
                  foregroundColor: ThemeConfig.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.apple_rounded, size: 20),
                label: const Text(
                  "App Store",
                  style: TextStyle(
                    fontFamily: "JetBrains Mono",
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            if (widget.project.projectUrl.isNotEmpty)
              OutlinedButton.icon(
                onPressed: () => _launchUrl(widget.project.projectUrl),
                style: OutlinedButton.styleFrom(
                  foregroundColor: ThemeConfig.primary,
                  side: BorderSide(color: ThemeConfig.primary, width: 1),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                icon: const Icon(Icons.open_in_new_rounded, size: 20),
                label: const Text(
                  "Website",
                  style: TextStyle(
                    fontFamily: "JetBrains Mono",
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // Background story & Features
  Widget _buildBackgroundAndFeatures(bool isMobile) {
    final double spacing = 48.0;
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBackgroundStory(),
          SizedBox(height: spacing),
          _buildKeyFeaturesCard(isMobile: true),
        ],
      );
    }

    return Row(
      key: _backgroundRowKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: StickyContainer(
            scrollController: _scrollController,
            parentKey: _backgroundRowKey,
            child: _buildBackgroundStory(),
          ),
        ),
        SizedBox(width: spacing),
        Expanded(
          flex: 1,
          child: _buildKeyFeaturesCard(isMobile: false),
        ),
      ],
    );
  }

  Widget _buildBackgroundStory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Background Story",
          style: ThemeConfig.h2,
        ),
        const SizedBox(height: 24),
        Text(
          widget.project.backgroundStory,
          style: ThemeConfig.body.copyWith(height: 1.7),
        ),
      ],
    );
  }

  Widget _buildKeyFeaturesCard({bool isMobile = false}) {
    return CustomCard(
      backgroundColor: ThemeConfig.surfaceContainerLow,
      padding: isMobile
          ? const EdgeInsets.symmetric(horizontal: 20, vertical: 24)
          : const EdgeInsets.all(32.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Key Features",
              style: ThemeConfig.h3,
            ),
            const SizedBox(height: 32),
            Column(
              children: widget.project.keyFeatures.map((feature) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: ThemeConfig.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              feature.title,
                              style: ThemeConfig.bodyBold.copyWith(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              feature.description,
                              style: ThemeConfig.body.copyWith(
                                fontSize: 14,
                                color: ThemeConfig.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
  }

  // Tech Stack Bento
  Widget _buildTechStackSection(double width) {
    final bool isMobile = width < 600;

    Widget techContent;
    if (isMobile) {
      techContent = SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.project.techStack.length,
          itemBuilder: (context, index) {
            final tech = widget.project.techStack[index];
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SizedBox(
                width: 132, // matches the childAspectRatio of 1.1 (120 * 1.1)
                child: TechStackGridItem(tech: tech),
              ),
            );
          },
        ),
      );
    } else {
      techContent = Center(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: widget.project.techStack.map((tech) {
            return SizedBox(
              width: 132,
              height: 120,
              child: TechStackGridItem(tech: tech),
            );
          }).toList(),
        ),
      );
    }

    return Column(
      children: [
        Text(
          "The Tech Stack",
          style: ThemeConfig.h2,
        ),
        const SizedBox(height: 48),
        techContent,
      ],
    );
  }

  // Clean Architecture Section with Mock IDE
  Widget _buildCleanArchitectureSection(bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCleanArchText(),
          const SizedBox(height: 32),
          _buildMockIDE(),
        ],
      );
    }

    return Row(
      key: _cleanArchRowKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: _buildCleanArchText(),
          ),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 2,
          child: StickyContainer(
            scrollController: _scrollController,
            parentKey: _cleanArchRowKey,
            child: _buildMockIDE(),
          ),
        ),
      ],
    );
  }

  Widget _buildCleanArchText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Clean Architecture",
          style: ThemeConfig.h2,
        ),
        const SizedBox(height: 24),
        Text(
          "Following strict separation of concerns, the project utilizes a Layered Clean Architecture (Domain, Data, Presentation). This ensures high testability, easy maintenance, and loose coupling.",
          style: ThemeConfig.body.copyWith(height: 1.7),
        ),
        const SizedBox(height: 32),
        _buildLayerCard(
          title: "Presentation Layer (UI & State)",
          description: "Handles responsive UI layout rendering, screen state, and reactive controller bindings (GetX/MVC).",
          icon: Icons.layers_outlined,
        ),
        const SizedBox(height: 12),
        _buildLayerCard(
          title: "Domain Layer (Business Rules)",
          description: "The core business logic layer housing entities and abstract contracts. Free of UI or network library dependencies.",
          icon: Icons.brightness_auto_outlined,
        ),
        const SizedBox(height: 12),
        _buildLayerCard(
          title: "Data Layer (Network & Cache)",
          description: "Manages network REST clients, data serializers, databases, and concrete repository implementations.",
          icon: Icons.storage_outlined,
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            ArchTag(label: "SOLID"),
            ArchTag(label: "DEPENDENCY INJECTION"),
            ArchTag(label: "REPOSITORY PATTERN"),
          ],
        ),
      ],
    );
  }

  Widget _buildLayerCard({required String title, required String description, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainerHigh.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ThemeConfig.outlineVariant.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Icon(
              icon,
              color: ThemeConfig.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ThemeConfig.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: ThemeConfig.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockIDE() {
    final lines = widget.project.codeSnippet.split('\n');

    return CustomCard(
      backgroundColor: ThemeConfig.surfaceContainerHigh.withValues(alpha: 0.2),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IDE Window Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: ThemeConfig.surfaceContainerHigh.withValues(alpha: 0.4),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(
                bottom: BorderSide(
                  color: ThemeConfig.outlineVariant.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                // Mac buttons
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF5F56),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFBD2E),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFF27C93F),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                // File Path
                Expanded(
                  child: Text(
                    widget.project.codeSnippetPath.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "JetBrains Mono",
                      fontSize: 11,
                      color: ThemeConfig.textSecondary,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Code Display Area
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Line numbers
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(lines.length, (idx) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          "${idx + 1}",
                          style: TextStyle(
                            fontFamily: "JetBrains Mono",
                            fontSize: 13,
                            color: ThemeConfig.textMuted,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 24),
                  // Code
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: lines.map((line) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: "JetBrains Mono",
                              fontSize: 13,
                              color: ThemeConfig.textPrimary,
                            ),
                            children: _highlightCode(line),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Simple syntax highlighter for Dart
  List<TextSpan> _highlightCode(String line) {
    final List<TextSpan> spans = [];

    int i = 0;
    while (i < line.length) {
      if (line.startsWith('class', i)) {
        spans.add(TextSpan(text: 'class', style: TextStyle(color: ThemeConfig.primary)));
        i += 5;
      } else if (line.startsWith('extends', i)) {
        spans.add(TextSpan(text: 'extends', style: TextStyle(color: ThemeConfig.primary)));
        i += 7;
      } else if (line.startsWith('void', i)) {
        spans.add(TextSpan(text: 'void', style: TextStyle(color: ThemeConfig.primary)));
        i += 4;
      } else if (line.startsWith('return', i)) {
        spans.add(TextSpan(text: 'return', style: TextStyle(color: ThemeConfig.primary)));
        i += 6;
      } else if (line.startsWith('override', i)) {
        spans.add(TextSpan(text: 'override', style: TextStyle(color: ThemeConfig.primary)));
        i += 8;
      } else if (line.startsWith('final', i)) {
        spans.add(TextSpan(text: 'final', style: TextStyle(color: ThemeConfig.primary)));
        i += 5;
      } else if (line.startsWith('@override', i)) {
        spans.add(TextSpan(text: '@override', style: TextStyle(color: ThemeConfig.textMuted)));
        i += 9;
      } else {
        spans.add(TextSpan(text: line[i]));
        i++;
      }
    }
    return spans.isEmpty ? [TextSpan(text: line)] : spans;
  }

  // Screenshots Gallery
  Widget _buildScreenshotsSection(bool isMobile) {
    return Column(
      children: [
        Text(
          "High-Fidelity Interface",
          style: ThemeConfig.h2,
        ),
        const SizedBox(height: 12),
        Text(
          "SWIPE TO EXPLORE • CLICK TO EXPAND",
          style: TextStyle(
            color: ThemeConfig.textMuted,
            fontFamily: "JetBrains Mono",
            fontSize: 10,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 32),
        ScreenshotsCarousel(
          screenshots: widget.project.screenshots,
          isMobile: isMobile,
          onImageTap: (url) => _openFullImageDialog(context, url),
        ),
      ],
    );
  }

  // Ecosystem Integrations Section
  Widget _buildIntegrationsSection(bool isMobile) {
    return Column(
      children: [
        Text(
          "Ecosystem Integrations",
          style: ThemeConfig.h3,
        ),
        const SizedBox(height: 32),
        Center(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: widget.project.integrations.map((integration) {
              IconData iconData = Icons.extension;
              if (integration.icon == "map") iconData = Icons.map;
              if (integration.icon == "payments") iconData = Icons.payments;
              if (integration.icon == "notifications_active") iconData = Icons.notifications_active;
              if (integration.icon == "dns") iconData = Icons.dns;
              if (integration.icon == "sync") iconData = Icons.sync;
              if (integration.icon == "folder_shared") iconData = Icons.folder_shared;
              if (integration.icon == "api") iconData = Icons.api;
              if (integration.icon == "shopping_cart") iconData = Icons.shopping_cart;
              if (integration.icon == "movie") iconData = Icons.movie;
              if (integration.icon == "monetization_on") iconData = Icons.monetization_on;

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: ThemeConfig.outlineVariant.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: ThemeConfig.outlineVariant.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      iconData,
                      color: ThemeConfig.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      integration.title,
                      style: TextStyle(
                        fontFamily: "JetBrains Mono",
                        color: ThemeConfig.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Footer Widget
  Widget _buildFooter(bool isMobile) {
    return Column(
      children: [
        const Divider(color: Color(0x1a859490)),
        const SizedBox(height: 48),
        if (isMobile)
          Column(
            children: [
              Text(
                "Flutter Architect",
                style: TextStyle(
                  fontFamily: "JetBrains Mono",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ThemeConfig.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "© 2024 Flutter Architect. Built with precision.",
                style: TextStyle(
                  color: ThemeConfig.textMuted,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              _buildFooterSocials(),
            ],
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Flutter Architect",
                    style: TextStyle(
                      fontFamily: "JetBrains Mono",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ThemeConfig.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "© 2024 Flutter Architect. Built with precision.",
                    style: TextStyle(
                      color: ThemeConfig.textMuted,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              _buildFooterSocials(),
            ],
          ),
      ],
    );
  }

  Widget _buildFooterSocials() {
    return Wrap(
      spacing: 24,
      children: [
        _buildSocialLink("Github", PortfolioData.github1),
        _buildSocialLink("LinkedIn", PortfolioData.linkedin),
        _buildSocialLink("Instagram", PortfolioData.instagram),
        _buildSocialLink("WhatsApp", PortfolioData.whatsapp),
        _buildSocialLink("Email", PortfolioData.emailUrl),
      ],
    );
  }

  Widget _buildSocialLink(String label, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(url),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: ThemeConfig.textMuted,
            fontSize: 12,
            fontFamily: "JetBrains Mono",
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// Clean Architecture Tags
class ArchTag extends StatelessWidget {
  final String label;

  const ArchTag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: ThemeConfig.textSecondary,
          fontFamily: "JetBrains Mono",
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Tech Stack grid item with hover interactions
class TechStackGridItem extends StatefulWidget {
  final TechItem tech;

  const TechStackGridItem({super.key, required this.tech});

  @override
  State<TechStackGridItem> createState() => _TechStackGridItemState();
}

class _TechStackGridItemState extends State<TechStackGridItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    IconData iconData = Icons.extension;
    if (widget.tech.icon == "flutter") iconData = Icons.flutter_dash;
    if (widget.tech.icon == "terminal") iconData = Icons.terminal;
    if (widget.tech.icon == "database") iconData = Icons.storage;
    if (widget.tech.icon == "local_fire_department") {
      iconData = Icons.local_fire_department;
    }
    if (widget.tech.icon == "api") iconData = Icons.api;
    if (widget.tech.icon == "rebase_edit") iconData = Icons.transform;
    if (widget.tech.icon == "sync") iconData = Icons.sync;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isHovered
              ? ThemeConfig.primary.withValues(alpha: 0.05)
              : ThemeConfig.outlineVariant.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? ThemeConfig.primary
                : ThemeConfig.outlineVariant.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: ThemeConfig.primary,
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              widget.tech.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "JetBrains Mono",
                fontSize: 12,
                color: ThemeConfig.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Screenshot item with hover animation
class ScreenshotGridItem extends StatefulWidget {
  final String imageUrl;
  final VoidCallback? onTap;

  const ScreenshotGridItem({super.key, required this.imageUrl, this.onTap});

  @override
  State<ScreenshotGridItem> createState() => _ScreenshotGridItemState();
}

class _ScreenshotGridItemState extends State<ScreenshotGridItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? (Matrix4.identity()..scale(1.05))
            : Matrix4.identity(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? ThemeConfig.primary.withValues(alpha: 0.6)
                  : ThemeConfig.outlineVariant.withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: ThemeConfig.primary.withValues(alpha: 0.15),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              widget.imageUrl,
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
              errorBuilder: (context, error, stackTrace) => Container(
                color: ThemeConfig.surfaceContainerHigh,
                child: Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: ThemeConfig.textMuted,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class ScreenshotsCarousel extends StatefulWidget {
  final List<String> screenshots;
  final bool isMobile;
  final Function(String) onImageTap;

  const ScreenshotsCarousel({
    super.key,
    required this.screenshots,
    required this.isMobile,
    required this.onImageTap,
  });

  @override
  State<ScreenshotsCarousel> createState() => _ScreenshotsCarouselState();
}

class _ScreenshotsCarouselState extends State<ScreenshotsCarousel> {
  late PageController _pageController;
  double _currentPage = 1000.0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: widget.isMobile ? 0.65 : 0.28,
      initialPage: 1000,
    );
    _pageController.addListener(() {
      if (mounted) {
        setState(() {
          _currentPage = _pageController.page ?? 1000.0;
        });
      }
    });
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double pageSlotWidth = screenWidth * (widget.isMobile ? 0.65 : 0.28);
    final double maxAllowedWidth = pageSlotWidth - 16;
    
    // Maintain a clean 9:16 aspect ratio
    final double maxItemHeight = widget.isMobile ? 320.0 : 440.0;
    double computedHeight = maxAllowedWidth * (16 / 9);
    
    if (computedHeight > maxItemHeight) {
      computedHeight = maxItemHeight;
    }
    final double computedWidth = computedHeight * (9 / 16);

    return SizedBox(
      height: widget.isMobile ? 360 : 490,
      child: PageView.builder(
        controller: _pageController,
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final int realIndex = index % widget.screenshots.length;
          final String screenshotUrl = widget.screenshots[realIndex];

          double diff = (_currentPage - index).abs();
          double scale = (1.05 - (diff * 0.15)).clamp(0.85, 1.05);
          double opacity = (1.0 - (diff * 0.5)).clamp(0.5, 1.0);

          return Center(
            child: Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: SizedBox(
                  width: computedWidth,
                  height: computedHeight,
                  child: ScreenshotGridItem(
                    imageUrl: screenshotUrl,
                    onTap: () {
                      _autoScrollTimer?.cancel();
                      widget.onImageTap(screenshotUrl);
                      Future.delayed(const Duration(seconds: 5), () {
                        if (mounted) _startAutoScroll();
                      });
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class StickyContainer extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final GlobalKey parentKey;

  const StickyContainer({
    super.key,
    required this.child,
    required this.scrollController,
    required this.parentKey,
  });

  @override
  State<StickyContainer> createState() => _StickyContainerState();
}

class _StickyContainerState extends State<StickyContainer> {
  final GlobalKey _childKey = GlobalKey();
  double _offsetTop = 0.0;
  double? _rowAbsoluteTop;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updateOffset);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateOffset);
    super.dispose();
  }

  void _updateOffset() {
    if (!mounted) return;

    final RenderBox? rowRenderBox = widget.parentKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? childRenderBox = _childKey.currentContext?.findRenderObject() as RenderBox?;

    if (rowRenderBox != null && childRenderBox != null) {
      if (_rowAbsoluteTop == null) {
        final ScrollableState? scrollable = Scrollable.of(context);
        final RenderBox? scrollRenderBox = scrollable?.context.findRenderObject() as RenderBox?;
        if (scrollRenderBox != null) {
          _rowAbsoluteTop = rowRenderBox.localToGlobal(Offset.zero, ancestor: scrollRenderBox).dy + widget.scrollController.offset;
        }
      }

      if (_rowAbsoluteTop != null) {
        final double rowHeight = rowRenderBox.size.height;
        final double childHeight = childRenderBox.size.height;
        final double currentScroll = widget.scrollController.offset;

        // Sticky offset starting 100 pixels from top of screen
        final double targetTopOffset = 100.0;
        double newOffset = currentScroll - _rowAbsoluteTop! + targetTopOffset;

        final double maxOffset = rowHeight - childHeight;
        if (newOffset > maxOffset) {
          newOffset = maxOffset;
        }
        if (newOffset < 0) {
          newOffset = 0;
        }

        if (_offsetTop != newOffset) {
          setState(() {
            _offsetTop = newOffset;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Opacity(
          opacity: 0,
          child: Container(
            key: _childKey,
            child: widget.child,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: _offsetTop,
          child: widget.child,
        ),
      ],
    );
  }
}


