import 'package:flutter/material.dart';
import '../data/theme_config.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final Function(int) onNavItemTap;
  final int activeIndex;
  final VoidCallback onMenuOpen;

  const Navbar({
    super.key,
    required this.onNavItemTap,
    required this.activeIndex,
    required this.onMenuOpen,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: ThemeConfig.background.withOpacity(0.85),
        border: Border(
          bottom: BorderSide(
            color: ThemeConfig.outlineVariant.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1280),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Brand Logo
              GestureDetector(
                onTap: () => onNavItemTap(0),
                child: const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    "<ashish.dev />",
                    style: TextStyle(
                      color: ThemeConfig.textPrimary,
                      fontFamily: "JetBrains Mono",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              // Nav items
              if (isMobile)
                IconButton(
                  icon: const Icon(Icons.menu_rounded, color: ThemeConfig.textPrimary),
                  onPressed: onMenuOpen,
                )
              else
                Row(
                  children: [
                    _buildNavItem("About", 1),
                    const SizedBox(width: 24),
                    _buildNavItem("Skills", 2),
                    const SizedBox(width: 24),
                    _buildNavItem("Experience", 3),
                    const SizedBox(width: 24),
                    _buildNavItem("Projects", 4),
                    const SizedBox(width: 24),
                    _buildNavItem("Education", 5),
                    const SizedBox(width: 24),
                    _buildNavItem("Contact", 6),
                    const SizedBox(width: 32),
                    // "Let's Talk" button
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => onNavItemTap(6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: ThemeConfig.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Let's Talk",
                            style: TextStyle(
                              color: ThemeConfig.onPrimary,
                              fontSize: 14,
                              fontFamily: "JetBrains Mono",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, int index) {
    final bool isActive = activeIndex == index;

    return NavItemWidget(
      title: title,
      isActive: isActive,
      onTap: () => onNavItemTap(index),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

class NavItemWidget extends StatefulWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const NavItemWidget({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<NavItemWidget> createState() => _NavItemWidgetState();
}

class _NavItemWidgetState extends State<NavItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.title,
          style: TextStyle(
            color: widget.isActive
                ? ThemeConfig.primary
                : (_isHovered ? ThemeConfig.primary : ThemeConfig.textSecondary),
            fontFamily: "JetBrains Mono",
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
