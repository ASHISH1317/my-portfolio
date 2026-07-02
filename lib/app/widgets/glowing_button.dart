import 'package:flutter/material.dart';
import '../data/theme_config.dart';

class GlowingButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSecondary;
  final IconData? icon;

  const GlowingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
    this.icon,
  });

  @override
  State<GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: widget.isSecondary
                ? (_isHovered ? ThemeConfig.surfaceContainerHigh : Colors.transparent)
                : ThemeConfig.primary,
            border: Border.all(
              color: widget.isSecondary
                  ? ThemeConfig.outline
                  : Colors.transparent,
              width: 1,
            ),
            boxShadow: widget.isSecondary
                ? []
                : [
                    BoxShadow(
                      color: ThemeConfig.primary.withOpacity(0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    )
                  ],
          ),
          transform: _isHovered
              ? (Matrix4.identity()..scale(1.02))
              : Matrix4.identity(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 18,
                  color: widget.isSecondary ? ThemeConfig.textPrimary : ThemeConfig.onPrimary,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: TextStyle(
                  color: widget.isSecondary ? ThemeConfig.textPrimary : ThemeConfig.onPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'JetBrains Mono',
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
