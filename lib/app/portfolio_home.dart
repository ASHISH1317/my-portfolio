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
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/education_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer.dart';
import 'controllers/home_controller.dart';
import 'controllers/theme_controller.dart';

class PortfolioHome extends GetView<HomeController> {
  const PortfolioHome({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() => Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: ThemeConfig.background,
      endDrawer: _buildMobileDrawer(context),
      body: Stack(
        key: ValueKey(themeController.rxThemeType.value),
        children: [
          // Slow dynamic ambient background
          const Positioned.fill(
            child: AnimatedBackground(),
          ),

          // Scrollable page content
          Positioned.fill(
            child: Column(
              children: [
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
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 1280),
                          child: Column(
                            children: [
                              HeroSection(
                                key: controller.sectionKeys[0],
                                onContactPressed: () => controller.scrollToSection(6),
                                onWorkPressed: () => controller.scrollToSection(4),
                              ),
                              AnimatedSectionDivider(),
                              AboutSection(key: controller.sectionKeys[1]),
                              AnimatedSectionDivider(),
                              SkillsSection(key: controller.sectionKeys[2]),
                              AnimatedSectionDivider(),
                              ExperienceSection(key: controller.sectionKeys[3]),
                              AnimatedSectionDivider(),
                              ProjectsSection(key: controller.sectionKeys[4]),
                              AnimatedSectionDivider(),
                              EducationSection(key: controller.sectionKeys[5]),
                              AnimatedSectionDivider(),
                              ContactSection(key: controller.sectionKeys[6]),
                              AnimatedSectionDivider(),
                              Footer(onNavItemTap: controller.scrollToSection),
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
    ));
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
                  _buildDrawerItem("About", 1),
                  _buildDrawerItem("Skills", 2),
                  _buildDrawerItem("Experience", 3),
                  _buildDrawerItem("Projects", 4),
                  _buildDrawerItem("Education", 5),
                  _buildDrawerItem("Contact", 6),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String title, int index) {
    final bool isActive = controller.activeIndex.value == index;
    return InkWell(
      onTap: () => controller.scrollToSection(index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isActive ? ThemeConfig.primary.withValues(alpha: 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? ThemeConfig.primary.withValues(alpha: 0.15) : Colors.transparent,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? ThemeConfig.primary : ThemeConfig.textSecondary,
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
