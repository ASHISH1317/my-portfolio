import 'package:flutter/material.dart';
import '../data/theme_config.dart';

class TiltCard extends StatefulWidget {
  final Widget child;
  final double maxTiltAngle;
  final BorderRadius? borderRadius;

  const TiltCard({
    super.key,
    required this.child,
    this.maxTiltAngle = 0.08,
    this.borderRadius,
  });

  @override
  State<TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<TiltCard> with SingleTickerProviderStateMixin {
  double _tiltX = 0.0;
  double _tiltY = 0.0;
  bool _isHovered = false;
  Offset _localHoverPos = Offset.zero;
  Size _cardSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isHovered = false;
          _tiltX = 0.0;
          _tiltY = 0.0;
        });
      },
      onHover: (event) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          _cardSize = renderBox.size;
          _localHoverPos = event.localPosition;
          
          final centerX = _cardSize.width / 2;
          final centerY = _cardSize.height / 2;

          final percentX = (event.localPosition.dx - centerX) / centerX;
          final percentY = (event.localPosition.dy - centerY) / centerY;

          setState(() {
            _tiltY = percentX * widget.maxTiltAngle;
            _tiltX = -percentY * widget.maxTiltAngle;
          });
        }
      },
      child: AnimatedContainer(
        duration: _isHovered ? Duration.zero : const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // perspective
          ..rotateX(_tiltX)
          ..rotateY(_tiltY),
        transformAlignment: Alignment.center,
        child: Stack(
          children: [
            widget.child,
            if (_isHovered)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
                      gradient: RadialGradient(
                        center: Alignment(
                          (_localHoverPos.dx / (_cardSize.width > 0 ? _cardSize.width : 1)) * 2 - 1,
                          (_localHoverPos.dy / (_cardSize.height > 0 ? _cardSize.height : 1)) * 2 - 1,
                        ),
                        radius: 0.8,
                        colors: [
                          ThemeConfig.primary.withValues(alpha: 0.12),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
