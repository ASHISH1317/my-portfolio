import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'data/theme_config.dart';
import 'widgets/animated_background.dart';
import 'widgets/animated_section_divider.dart';
import 'widgets/smooth_scroll_wrapper.dart';
import 'sections/navbar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/packages_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/education_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer.dart';
import 'controllers/home_controller.dart';
import 'controllers/theme_controller.dart';

import 'package:flutter/services.dart';
import 'widgets/scroll_progress_indicator.dart';
import 'widgets/quick_actions_chip.dart';


class PortfolioHome extends GetView<HomeController> {
  const PortfolioHome({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.keyT): () => themeController.cycleTheme(),
        const SingleActivator(LogicalKeyboardKey.digit1): () => controller.scrollToSection(1),
        const SingleActivator(LogicalKeyboardKey.digit2): () => controller.scrollToSection(2),
        const SingleActivator(LogicalKeyboardKey.digit3): () => controller.scrollToSection(3),
        const SingleActivator(LogicalKeyboardKey.digit4): () => controller.scrollToSection(4),
        const SingleActivator(LogicalKeyboardKey.digit5): () => controller.scrollToSection(5),
        const SingleActivator(LogicalKeyboardKey.digit6): () => controller.scrollToSection(6),
        const SingleActivator(LogicalKeyboardKey.digit7): () => controller.scrollToSection(7),
      },
      child: Focus(
        autofocus: true,
        child: Obx(() => Scaffold(
          key: controller.scaffoldKey,
          backgroundColor: ThemeConfig.background,
          endDrawer: _buildMobileDrawer(context),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 8),
            child: QuickActionsChip(scrollController: controller.scrollController),
          ),
          body: Stack(
            children: [
              // Slow dynamic ambient background
              const Positioned.fill(
                child: AnimatedBackground(),
              ),

              // Scrollable page content
              Positioned.fill(
                child: Column(
                  children: [
                    // Top Reading Progress Bar
                    ScrollProgressIndicator(scrollController: controller.scrollController),

                    // Floating top navigation bar
                    Obx(() => Navbar(
                      activeIndex: controller.activeIndex.value,
                      onNavItemTap: controller.scrollToSection,
                      onMenuOpen: () => controller.scaffoldKey.currentState?.openEndDrawer(),
                    )),

                    // Main Section list
                    Expanded(
                      child: SmoothScrollWrapper(
                        controller: controller.scrollController,
                        child: SingleChildScrollView(
                          controller: controller.scrollController,
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  constraints: const BoxConstraints(maxWidth: 1280),
                                  child: Column(
                                    children: [
                                      HeroSection(
                                        key: controller.sectionKeys[0],
                                        onContactPressed: () => controller.scrollToSection(7),
                                        onWorkPressed: () => controller.scrollToSection(5),
                                      ),
                                      AnimatedSectionDivider(),
                                      AboutSection(key: controller.sectionKeys[1]),
                                      AnimatedSectionDivider(),
                                      SkillsSection(key: controller.sectionKeys[2]),
                                      AnimatedSectionDivider(),
                                      ExperienceSection(key: controller.sectionKeys[3]),
                                      AnimatedSectionDivider(),
                                      PackagesSection(key: controller.sectionKeys[4]),
                                      AnimatedSectionDivider(),
                                      ProjectsSection(key: controller.sectionKeys[5]),
                                      AnimatedSectionDivider(),
                                      EducationSection(key: controller.sectionKeys[6]),
                                      AnimatedSectionDivider(),
                                      ContactSection(key: controller.sectionKeys[7]),
                                    ],
                                  ),
                                ),
                              ),
                              AnimatedSectionDivider(),
                              Footer(onNavItemTap: controller.scrollToSection),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Floating Bottom Keyboard Shortcut Legend Banner (Desktop)
              if (MediaQuery.of(context).size.width >= 768)
                const Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: _FloatingShortcutLegend(),
                  ),
                ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildMobileDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: ThemeConfig.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "NAVIGATION",
                    style: TextStyle(
                      color: ThemeConfig.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded, color: ThemeConfig.textPrimary),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
              const SizedBox(height: 40),
              Obx(() => Column(
                children: [
                  _buildDrawerItem("Home", 0),
                  _buildDrawerItem("About", 1, shortcutKey: "1"),
                  _buildDrawerItem("Skills", 2, shortcutKey: "2"),
                  _buildDrawerItem("Experience", 3, shortcutKey: "3"),
                  _buildDrawerItem("Packages", 4, shortcutKey: "4"),
                  _buildDrawerItem("Projects", 5, shortcutKey: "5"),
                  _buildDrawerItem("Education", 6, shortcutKey: "6"),
                  _buildDrawerItem("Contact", 7, shortcutKey: "7"),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String title, int index, {String? shortcutKey}) {
    final bool isActive = controller.activeIndex.value == index;
    return InkWell(
      onTap: () => controller.scrollToSection(index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isActive ? ThemeConfig.primary.withValues(alpha: 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? ThemeConfig.primary.withValues(alpha: 0.15) : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isActive ? ThemeConfig.primary : ThemeConfig.textSecondary,
                fontSize: 16,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            if (shortcutKey != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isActive
                      ? ThemeConfig.primary.withValues(alpha: 0.15)
                      : ThemeConfig.surfaceContainerLow.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isActive
                        ? ThemeConfig.primary.withValues(alpha: 0.3)
                        : ThemeConfig.outlineVariant.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  "[$shortcutKey]",
                  style: TextStyle(
                    color: isActive ? ThemeConfig.primary : ThemeConfig.textMuted,
                    fontFamily: "JetBrains Mono",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _FloatingShortcutLegend extends StatefulWidget {
  const _FloatingShortcutLegend();

  @override
  State<_FloatingShortcutLegend> createState() => _FloatingShortcutLegendState();
}

class _FloatingShortcutLegendState extends State<_FloatingShortcutLegend> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -4, 0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: _isHovered
              ? ThemeConfig.surfaceContainerHigh.withValues(alpha: 0.95)
              : ThemeConfig.surfaceContainerLow.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? ThemeConfig.primary.withValues(alpha: 0.6)
                : ThemeConfig.primary.withValues(alpha: 0.25),
            width: _isHovered ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? ThemeConfig.primary.withValues(alpha: 0.25)
                  : Colors.black.withValues(alpha: 0.25),
              blurRadius: _isHovered ? 24 : 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedRotation(
              turns: _isHovered ? 0.05 : 0,
              duration: const Duration(milliseconds: 250),
              child: Icon(
                Icons.keyboard_outlined,
                size: 16,
                color: ThemeConfig.primary,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "QUICK JUMP: ",
              style: TextStyle(
                color: ThemeConfig.primary,
                fontFamily: "JetBrains Mono",
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              "Press ",
              style: TextStyle(
                color: ThemeConfig.textSecondary,
                fontFamily: "JetBrains Mono",
                fontSize: 12,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _isHovered
                    ? ThemeConfig.primary
                    : ThemeConfig.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: _isHovered
                      ? ThemeConfig.primary
                      : ThemeConfig.primary.withValues(alpha: 0.3),
                  width: 1,
                ),
                boxShadow: [
                  if (_isHovered)
                    BoxShadow(
                      color: ThemeConfig.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                    ),
                ],
              ),
              child: Text(
                "1 - 7",
                style: TextStyle(
                  color: _isHovered ? ThemeConfig.onPrimary : ThemeConfig.primary,
                  fontFamily: "JetBrains Mono",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              " to navigate sections",
              style: TextStyle(
                color: ThemeConfig.textSecondary,
                fontFamily: "JetBrains Mono",
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
