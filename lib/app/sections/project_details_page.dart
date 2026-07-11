import 'package:flutter/material.dart';
import 'dart:ui';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/custom_card.dart';
import '../widgets/animated_section_divider.dart';
import '../widgets/smooth_scroll_wrapper.dart';

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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;

    return Scaffold(
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
                color: ThemeConfig.primary.withOpacity(0.04),
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
                color: ThemeConfig.primary.withOpacity(0.02),
              ),
            ),
          ),

          // Scrollable content
          Positioned.fill(
            child: Column(
              children: [
                _buildHeader(context, isMobile),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              _buildHeroSection(isMobile),
                              const SizedBox(height: 40),
                              AnimatedSectionDivider(),
                              const SizedBox(height: 40),
                              _buildBackgroundAndFeatures(isMobile),
                              const SizedBox(height: 40),
                              AnimatedSectionDivider(),
                              const SizedBox(height: 40),
                              _buildTechStackSection(width),
                              const SizedBox(height: 40),
                              AnimatedSectionDivider(),
                              const SizedBox(height: 40),
                              _buildCleanArchitectureSection(isMobile),
                              const SizedBox(height: 40),
                              AnimatedSectionDivider(),
                              const SizedBox(height: 40),
                              _buildScreenshotsSection(isMobile),
                              const SizedBox(height: 40),
                              AnimatedSectionDivider(),
                              const SizedBox(height: 40),
                              _buildIntegrationsSection(isMobile),
                              const SizedBox(height: 80),
                              _buildFooter(isMobile),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Header Navigation Bar
  Widget _buildHeader(BuildContext context, bool isMobile) {
    return Container(
      height: 64,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeConfig.background.withOpacity(0.8),
        border: const Border(
          bottom: BorderSide(
            color: Color(0x1a859490),
            width: 1,
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded, color: ThemeConfig.primary),
                      onPressed: () => Navigator.of(context).pop(),
                      splashRadius: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Portfolio",
                      style: TextStyle(
                        fontFamily: "JetBrains Mono",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ThemeConfig.primary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                if (!isMobile)
                  Row(
                    children: [
                      _buildHeaderLink("Projects", context, true),
                      const SizedBox(width: 32),
                      _buildHeaderLink("About", context, false),
                      const SizedBox(width: 32),
                      _buildHeaderLink("Resume", context, false),
                      const SizedBox(width: 32),
                      _buildHeaderLink("Contact", context, false),
                    ],
                  ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.code_rounded, color: ThemeConfig.textSecondary, size: 20),
                      onPressed: () {},
                      tooltip: "View Code",
                    ),
                    IconButton(
                      icon: Icon(Icons.terminal_rounded, color: ThemeConfig.textSecondary, size: 20),
                      onPressed: () {},
                      tooltip: "Console",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderLink(String label, BuildContext context, bool isActive) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? ThemeConfig.primary : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? ThemeConfig.primary : ThemeConfig.textSecondary,
              fontFamily: "JetBrains Mono",
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
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
                border: Border.all(color: ThemeConfig.primary.withOpacity(0.8), width: 1),
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
            ElevatedButton.icon(
              onPressed: () {},
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
            OutlinedButton.icon(
              onPressed: () {},
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
                "Live Demo",
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
          _buildKeyFeaturesCard(),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: _buildBackgroundStory(),
        ),
        SizedBox(width: spacing),
        Expanded(
          flex: 1,
          child: _buildKeyFeaturesCard(),
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

  Widget _buildKeyFeaturesCard() {
    return CustomCard(
      backgroundColor: ThemeConfig.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
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
      ),
    );
  }

  // Tech Stack Bento
  Widget _buildTechStackSection(double width) {
    int crossAxisCount = 6;
    if (width < 600) {
      crossAxisCount = 2;
    } else if (width < 900) {
      crossAxisCount = 3;
    }

    return Column(
      children: [
        Text(
          "The Tech Stack",
          style: ThemeConfig.h2,
        ),
        const SizedBox(height: 48),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: widget.project.techStack.length,
          itemBuilder: (context, index) {
            final tech = widget.project.techStack[index];
            return TechStackGridItem(tech: tech);
          },
        ),
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
          child: _buildMockIDE(),
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
          "Following strict separation of concerns, the project utilizes a Layered Clean Architecture (Domain, Data, Presentation). This ensures testability, maintainability, and easy integration of new features.",
          style: ThemeConfig.body.copyWith(height: 1.7),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            ArchTag(label: "SOLID"),
            ArchTag(label: "MVC"),
            ArchTag(label: "REPOSITORY"),
          ],
        ),
      ],
    );
  }

  Widget _buildMockIDE() {
    final lines = widget.project.codeSnippet.split('\n');

    return CustomCard(
      backgroundColor: const Color(0xFF0E0E0E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IDE Window Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(
                bottom: BorderSide(
                  color: Color(0x22859490),
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
        const SizedBox(height: 48),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : (widget.project.screenshots.length >= 4 ? 4 : widget.project.screenshots.length),
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 9 / 16,
          ),
          itemCount: widget.project.screenshots.length,
          itemBuilder: (context, index) {
            final screenshotUrl = widget.project.screenshots[index];
            return ScreenshotGridItem(imageUrl: screenshotUrl);
          },
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

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: ThemeConfig.outlineVariant.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: ThemeConfig.outlineVariant.withOpacity(0.3),
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
        _buildSocialLink("Github"),
        _buildSocialLink("LinkedIn"),
        _buildSocialLink("Twitter"),
        _buildSocialLink("Email"),
      ],
    );
  }

  Widget _buildSocialLink(String label) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
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
                : ThemeConfig.outlineVariant.withOpacity(0.3),
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

  const ScreenshotGridItem({super.key, required this.imageUrl});

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
                  ? ThemeConfig.primary.withOpacity(0.6)
                  : ThemeConfig.outlineVariant.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: ThemeConfig.primary.withOpacity(0.15),
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
    );
  }
}
