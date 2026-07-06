import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'data/theme_config.dart';
import 'widgets/animated_background.dart';
import 'widgets/animated_section_divider.dart';
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

class PortfolioHome extends GetView<HomeController> {
  const PortfolioHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: ThemeConfig.background,
      endDrawer: _buildMobileDrawer(context),
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
                // Floating top navigation bar
                Obx(() => Navbar(
                  activeIndex: controller.activeIndex.value,
                  onNavItemTap: controller.scrollToSection,
                  onMenuOpen: () => controller.scaffoldKey.currentState?.openEndDrawer(),
                )),

                // Main Section list
                Expanded(
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
                            const AnimatedSectionDivider(),
                            AboutSection(key: controller.sectionKeys[1]),
                            const AnimatedSectionDivider(),
                            SkillsSection(key: controller.sectionKeys[2]),
                            const AnimatedSectionDivider(),
                            ExperienceSection(key: controller.sectionKeys[3]),
                            const AnimatedSectionDivider(),
                            ProjectsSection(key: controller.sectionKeys[4]),
                            const AnimatedSectionDivider(),
                            EducationSection(key: controller.sectionKeys[5]),
                            const AnimatedSectionDivider(),
                            ContactSection(key: controller.sectionKeys[6]),
                            const AnimatedSectionDivider(),
                            Footer(onNavItemTap: controller.scrollToSection),
                          ],
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
                  const Text(
                    "NAVIGATION",
                    style: TextStyle(
                      color: ThemeConfig.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
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
          color: isActive ? ThemeConfig.primary.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? ThemeConfig.primary.withOpacity(0.15) : Colors.transparent,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? ThemeConfig.primary : Colors.white70,
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
