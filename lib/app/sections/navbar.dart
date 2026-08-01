import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/theme_config.dart';
import '../widgets/theme_selector.dart';

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
                child: MouseRegion(
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
              ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.2, end: 0),
              // Nav items
              if (isMobile)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ThemeSelector(),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.menu_rounded, color: ThemeConfig.textPrimary),
                      onPressed: onMenuOpen,
                    ),
                  ],
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
                    const SizedBox(width: 24),
                    const ThemeSelector(),
                    const SizedBox(width: 24),
                    // "Let's Talk" button
                    _LetsTalkButton(onTap: () => onNavItemTap(6)),
                  ],
                ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.2, end: 0),
            ],
          ),
        ),
      ),
    ).animate().slideY(begin: -1, end: 0, duration: 600.ms, curve: Curves.easeOutQuad).fadeIn(duration: 500.ms);
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

class _LetsTalkButton extends StatefulWidget {
  final VoidCallback onTap;
  const _LetsTalkButton({required this.onTap});

  @override
  State<_LetsTalkButton> createState() => _LetsTalkButtonState();
}

class _LetsTalkButtonState extends State<_LetsTalkButton> {
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
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered ? ThemeConfig.primary : ThemeConfig.primary.withOpacity(0.85),
            borderRadius: BorderRadius.circular(8),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: ThemeConfig.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0, -2, 0))
              : Matrix4.identity(),
          child: Text(
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
    );
  }
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
    final bool isHighlighted = widget.isActive || _isHovered;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
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
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              height: 2,
              width: isHighlighted ? 16 : 0,
              decoration: BoxDecoration(
                color: ThemeConfig.primary,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
