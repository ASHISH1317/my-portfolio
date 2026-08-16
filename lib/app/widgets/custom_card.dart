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
  final bool enableTilt;
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
    this.enableTilt = true,
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
    final bool hoverActive = _isHovered && widget.enableHover;

    Widget cardWidget = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Obx(() {
          final Color innerBgColor = widget.backgroundColor ?? 
              (hoverActive ? ThemeConfig.surfaceContainerHigh : ThemeConfig.surface);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(1.5), // Outer border thickness
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              gradient: hoverActive
                  ? LinearGradient(
                      colors: [
                        ThemeConfig.primary,
                        ThemeConfig.primary.withValues(alpha: 0.3),
                        ThemeConfig.outlineVariant.withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: [
                        ThemeConfig.outline.withValues(alpha: 0.15),
                        ThemeConfig.outline.withValues(alpha: 0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              boxShadow: hoverActive
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius - 1.5),
              child: Container(
                color: innerBgColor,
                padding: widget.padding ?? const EdgeInsets.all(24),
                child: widget.child,
              ),
            ),
          );
        }),
      ),
    );

    if (widget.enableHover && widget.enableTilt) {
      return TiltCard(
        borderRadius: BorderRadius.circular(radius),
        child: cardWidget,
      );
    }

    return cardWidget;
  }
}
