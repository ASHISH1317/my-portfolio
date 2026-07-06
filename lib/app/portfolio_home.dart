import 'package:flutter/material.dart';
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

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Global keys to track 7 section positions (Hero, About, Skills, Experience, Projects, Education, Contact)
  final List<GlobalKey> _sectionKeys = List.generate(7, (index) => GlobalKey());
  
  int _activeIndex = 0;
  bool _isScrollingAutomatically = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isScrollingAutomatically) return;

    // Detect which section is currently most visible in the viewport
    double scrollPosition = _scrollController.position.pixels;
    int nearestIndex = 0;
    double minDistance = double.maxFinite;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final context = _sectionKeys[i].currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          // We want the section closest to the top of the viewport
          final distance = position.dy.abs();
          if (distance < minDistance) {
            minDistance = distance;
            nearestIndex = i;
          }
        }
      }
    }

    if (_activeIndex != nearestIndex) {
      setState(() {
        _activeIndex = nearestIndex;
      });
    }
  }

  void _scrollToSection(int index) {
    if (index < 0 || index >= _sectionKeys.length) return;

    // Close drawer if open (for mobile devices)
    if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }

    final sectionContext = _sectionKeys[index].currentContext;
    if (sectionContext != null) {
      setState(() {
        _activeIndex = index;
        _isScrollingAutomatically = true;
      });

      Scrollable.ensureVisible(
        sectionContext,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      ).then((_) {
        // Wait briefly for scroll physics to settle before allowing scroll updates to trigger activeIndex shifts
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              _isScrollingAutomatically = false;
            });
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ThemeConfig.background,
      endDrawer: _buildMobileDrawer(),
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
                Navbar(
                  activeIndex: _activeIndex,
                  onNavItemTap: _scrollToSection,
                  onMenuOpen: () => _scaffoldKey.currentState?.openEndDrawer(),
                ),

                // Main Section list
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: Column(
                          children: [
                            HeroSection(
                              key: _sectionKeys[0],
                              onContactPressed: () => _scrollToSection(6),
                              onWorkPressed: () => _scrollToSection(4),
                            ),
                            const AnimatedSectionDivider(),
                            AboutSection(key: _sectionKeys[1]),
                            const AnimatedSectionDivider(),
                            SkillsSection(key: _sectionKeys[2]),
                            const AnimatedSectionDivider(),
                            ExperienceSection(key: _sectionKeys[3]),
                            const AnimatedSectionDivider(),
                            ProjectsSection(key: _sectionKeys[4]),
                            const AnimatedSectionDivider(),
                            EducationSection(key: _sectionKeys[5]),
                            const AnimatedSectionDivider(),
                            ContactSection(key: _sectionKeys[6]),
                            const AnimatedSectionDivider(),
                            Footer(onNavItemTap: _scrollToSection),
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

  Widget _buildMobileDrawer() {
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
              _buildDrawerItem("Home", 0),
              _buildDrawerItem("About", 1),
              _buildDrawerItem("Skills", 2),
              _buildDrawerItem("Experience", 3),
              _buildDrawerItem("Projects", 4),
              _buildDrawerItem("Education", 5),
              _buildDrawerItem("Contact", 6),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String title, int index) {
    final bool isActive = _activeIndex == index;
    return InkWell(
      onTap: () => _scrollToSection(index),
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
