import 'package:flutter/material.dart';
import '../data/theme_config.dart';

class CustomCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool highlightBorder;
  final Color? glowColor;
  final Color? backgroundColor;

  const CustomCard({
    super.key,
    required this.child,
    this.onTap,
    this.highlightBorder = false,
    this.glowColor,
    this.backgroundColor,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final activeColor = widget.glowColor ?? ThemeConfig.primary;
    final bg = widget.backgroundColor ?? ThemeConfig.surfaceContainerLow;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            transform: _isHovered
                ? (Matrix4.identity()..translate(0, -6, 0)..scale(1.02))
                : Matrix4.identity(),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered
                    ? activeColor.withOpacity(0.6)
                    : (widget.highlightBorder ? ThemeConfig.primary.withOpacity(0.3) : ThemeConfig.outlineVariant.withOpacity(0.3)),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? activeColor.withOpacity(0.15)
                      : Colors.transparent,
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
