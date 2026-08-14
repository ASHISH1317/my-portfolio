import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/theme_config.dart';

class CustomCursorWrapper extends StatefulWidget {
  final Widget child;

  const CustomCursorWrapper({super.key, required this.child});

  @override
  State<CustomCursorWrapper> createState() => _CustomCursorWrapperState();
}

class _CustomCursorWrapperState extends State<CustomCursorWrapper> {
  Offset _pointerPos = Offset.zero;
  bool _isVisible = false;
  bool _isClicking = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isVisible = true),
      onExit: (event) => setState(() => _isVisible = false),
      onHover: (event) {
        setState(() {
          _pointerPos = event.position;
          _isVisible = true;
        });
      },
      child: Listener(
        onPointerDown: (_) => setState(() => _isClicking = true),
        onPointerUp: (_) => setState(() => _isClicking = false),
        child: Stack(
          children: [
            widget.child,
            if (_isVisible)
              Obx(() {
                final primaryColor = ThemeConfig.primary;
                return IgnorePointer(
                  child: Stack(
                    children: [
                      // Smooth trailing ring
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 60),
                        curve: Curves.easeOutCubic,
                        left: _pointerPos.dx - (_isClicking ? 18 : 24),
                        top: _pointerPos.dy - (_isClicking ? 18 : 24),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: _isClicking ? 36 : 48,
                          height: _isClicking ? 36 : 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primaryColor.withValues(alpha: 0.5),
                              width: 1.5,
                            ),
                            color: primaryColor.withValues(alpha: _isClicking ? 0.15 : 0.05),
                          ),
                        ),
                      ),
                      // Core inner dot
                      Positioned(
                        left: _pointerPos.dx - 4,
                        top: _pointerPos.dy - 4,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withValues(alpha: 0.8),
                                blurRadius: 8,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
