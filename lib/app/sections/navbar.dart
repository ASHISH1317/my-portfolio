import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/theme_config.dart';
import '../widgets/theme_selector.dart';
import '../widgets/resume_preview_dialog.dart';

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
    final bool isMobile = width < 1150;
    final double itemSpacing = width < 1300 ? 12.0 : 20.0;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: ThemeConfig.background.withValues(alpha: 0.75),
            border: Border(
              bottom: BorderSide(
                color: ThemeConfig.outlineVariant.withValues(alpha: 0.3),
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/app_icon/app_icon_nobg.png",
                            width: 26,
                            height: 26,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "<ashish.dev />",
                            style: TextStyle(
                              color: ThemeConfig.textPrimary,
                              fontFamily: "JetBrains Mono",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.2, end: 0),
                  // Nav items
                  if (isMobile)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'Resume Preview',
                          icon: Icon(Icons.description_outlined, color: ThemeConfig.primary),
                          onPressed: () => ResumePreviewDialog.show(context),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(Icons.menu_rounded, color: ThemeConfig.textPrimary),
                          onPressed: onMenuOpen,
                        ),
                        const SizedBox(width: 8),
                        const ThemeSelector(),
                      ],
                    )
                  else
                    Row(
                      children: [
                        _buildNavItem("About", 1),
                        SizedBox(width: itemSpacing),
                        _buildNavItem("Skills", 2),
                        SizedBox(width: itemSpacing),
                        _buildNavItem("Experience", 3),
                        SizedBox(width: itemSpacing),
                        _buildNavItem("Packages", 4),
                        SizedBox(width: itemSpacing),
                        _buildNavItem("Projects", 5),
                        SizedBox(width: itemSpacing),
                        _buildNavItem("Education", 6),
                        SizedBox(width: itemSpacing),
                        _buildNavItem("Contact", 7),
                        SizedBox(width: itemSpacing + 4),
                        // Resume button
                        OutlinedButton.icon(
                          onPressed: () => ResumePreviewDialog.show(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: ThemeConfig.primary,
                            side: BorderSide(color: ThemeConfig.primary.withOpacity(0.5)),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          icon: const Icon(Icons.description_outlined, size: 16),
                          label: const Text(
                            "Resume",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // "Let's Talk" button
                        _LetsTalkButton(onTap: () => onNavItemTap(7)),
                        const SizedBox(width: 16),
                        const ThemeSelector(),
                      ],
                    ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.2, end: 0),
                ],
              ),
            ),
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
      index: index,
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
    final Color contentColor = _isHovered ? ThemeConfig.onPrimary : ThemeConfig.primary;
    final Color bgColor = _isHovered ? ThemeConfig.primary : ThemeConfig.primary.withValues(alpha: 0.05);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: OutlinedButton.icon(
          onPressed: widget.onTap,
          style: OutlinedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: contentColor,
            side: BorderSide(
              color: _isHovered ? ThemeConfig.primary : ThemeConfig.primary.withValues(alpha: 0.4),
              width: 1.5,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          icon: Icon(
            Icons.chat_bubble_outline_rounded,
            size: 16,
            color: contentColor,
          ),
          label: Text(
            "Let's Talk",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              fontFamily: "JetBrains Mono",
              color: contentColor,
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
  final int? index;

  const NavItemWidget({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
    this.index,
  });

  @override
  State<NavItemWidget> createState() => _NavItemWidgetState();
}

class _NavItemWidgetState extends State<NavItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isHighlighted = widget.isActive || _isHovered;
    final double width = MediaQuery.of(context).size.width;
    final bool showBadge = width >= 1300;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 6),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.isActive
                        ? ThemeConfig.primary
                        : (_isHovered ? ThemeConfig.primary : ThemeConfig.textSecondary),
                    fontFamily: "JetBrains Mono",
                    fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                if (widget.index != null && showBadge) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                    decoration: BoxDecoration(
                      color: isHighlighted
                          ? ThemeConfig.primary.withValues(alpha: 0.15)
                          : ThemeConfig.outlineVariant.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isHighlighted
                            ? ThemeConfig.primary.withValues(alpha: 0.3)
                            : ThemeConfig.outlineVariant.withValues(alpha: 0.25),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      "${widget.index}",
                      style: TextStyle(
                        color: isHighlighted ? ThemeConfig.primary : ThemeConfig.textMuted,
                        fontFamily: "JetBrains Mono",
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              height: 2,
              width: isHighlighted ? 18 : 0,
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
