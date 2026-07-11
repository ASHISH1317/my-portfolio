import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import '../data/theme_config.dart';

class CoolDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color accentColor;
  final String primaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;

  CoolDialog({
    Key? key,
    required this.title,
    required this.message,
    this.icon = Icons.info_outline_rounded,
    Color? accentColor,
    required this.primaryButtonText,
    this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
  }) : accentColor = accentColor ?? ThemeConfig.primary,
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 440),
          decoration: BoxDecoration(
            color: ThemeConfig.surfaceContainerLow.withOpacity(0.9),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: accentColor.withOpacity(0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(0.12),
                blurRadius: 30,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // Diagonal ambient glow light
                Positioned(
                  top: -60,
                  right: -60,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: accentColor.withOpacity(0.15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header Icon Badge
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: accentColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withOpacity(0.2),
                              blurRadius: 16,
                              spreadRadius: -2,
                            ),
                          ],
                        ),
                        child: Icon(
                          icon,
                          color: accentColor,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Title
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Message
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: ThemeConfig.textSecondary.withOpacity(0.9),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (secondaryButtonText != null) ...[
                            Expanded(
                              child: _CoolDialogButton(
                                text: secondaryButtonText!,
                                onPressed: onSecondaryPressed ?? () => Navigator.of(context).pop(),
                                isPrimary: false,
                                accentColor: accentColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            child: _CoolDialogButton(
                              text: primaryButtonText,
                              onPressed: onPrimaryPressed ?? () => Navigator.of(context).pop(),
                              isPrimary: true,
                              accentColor: accentColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CoolDialogButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final Color accentColor;

  const _CoolDialogButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isPrimary,
    required this.accentColor,
  }) : super(key: key);

  @override
  State<_CoolDialogButton> createState() => _CoolDialogButtonState();
}

class _CoolDialogButtonState extends State<_CoolDialogButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double opacity = _isHovered ? 1.0 : 0.85;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: widget.isPrimary
                ? LinearGradient(
                    colors: [
                      widget.accentColor.withOpacity(opacity),
                      widget.accentColor.withOpacity(opacity * 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            border: !widget.isPrimary
                ? Border.all(
                    color: ThemeConfig.outlineVariant.withOpacity(_isHovered ? 0.8 : 0.4),
                    width: 1.5,
                  )
                : null,
            color: !widget.isPrimary
                ? (_isHovered
                    ? ThemeConfig.surfaceContainerHigh.withOpacity(0.5)
                    : Colors.transparent)
                : null,
            boxShadow: widget.isPrimary && _isHovered
                ? [
                    BoxShadow(
                      color: widget.accentColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.isPrimary ? Colors.black : ThemeConfig.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

void showCoolDialog({
  required BuildContext context,
  required String title,
  required String message,
  IconData icon = Icons.info_outline_rounded,
  Color? accentColor,
  required String primaryButtonText,
  VoidCallback? onPrimaryPressed,
  String? secondaryButtonText,
  VoidCallback? onSecondaryPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.7),
    builder: (context) => CoolDialog(
      title: title,
      message: message,
      icon: icon,
      accentColor: accentColor ?? ThemeConfig.primary,
      primaryButtonText: primaryButtonText,
      onPrimaryPressed: onPrimaryPressed,
      secondaryButtonText: secondaryButtonText,
      onSecondaryPressed: onSecondaryPressed,
    ),
  );
}
