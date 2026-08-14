import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/theme_config.dart';
import 'tilt_card.dart';

class CustomCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double? borderRadius;
  final bool enableHover;
  final Color? glowColor;
  final Color? backgroundColor;
  final bool highlightBorder;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderRadius,
    this.enableHover = true,
    this.glowColor,
    this.backgroundColor,
    this.highlightBorder = false,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double radius = widget.borderRadius ?? 16.0;

    Widget cardWidget = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: widget.padding ?? const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _isHovered && widget.enableHover
                ? ThemeConfig.surfaceContainerHigh
                : ThemeConfig.surface,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: _isHovered && widget.enableHover
                  ? ThemeConfig.primary.withValues(alpha: 0.5)
                  : ThemeConfig.outline,
              width: 1,
            ),
            boxShadow: _isHovered && widget.enableHover
                ? [
                    BoxShadow(
                      color: ThemeConfig.primary.withValues(alpha: 0.15),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: widget.child,
        )),
      ),
    );

    if (widget.enableHover) {
      return TiltCard(
        borderRadius: BorderRadius.circular(radius),
        child: cardWidget,
      );
    }

    return cardWidget;
  }
}
