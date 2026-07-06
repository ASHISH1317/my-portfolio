import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../data/theme_config.dart';

class AnimatedSectionDivider extends StatefulWidget {
  final double height;
  final Duration duration;

  const AnimatedSectionDivider({
    super.key,
    this.height = 1.2,
    this.duration = const Duration(milliseconds: 2500),
  });

  @override
  State<AnimatedSectionDivider> createState() => _AnimatedSectionDividerState();
}

class _AnimatedSectionDividerState extends State<AnimatedSectionDivider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true); // Reverse for a smooth pulsing breathe effect
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48, // Height of the divider area to give sections some breathing room
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // The animation value goes from 0.0 to 1.0, then 1.0 to 0.0
          return CustomPaint(
            size: Size(double.infinity, widget.height),
            painter: _DividerPainter(
              pulse: _controller.value,
              color: ThemeConfig.primary,
              baseColor: ThemeConfig.outlineVariant.withOpacity(0.15),
            ),
          );
        },
      ),
    );
  }
}

class _DividerPainter extends CustomPainter {
  final double pulse;
  final Color color;
  final Color baseColor;

  _DividerPainter({
    required this.pulse,
    required this.color,
    required this.baseColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw the background subtle line that fades out at the edges
    final Paint basePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          baseColor.withOpacity(0.0),
          baseColor,
          baseColor,
          baseColor.withOpacity(0.0),
        ],
        stops: const [0.0, 0.15, 0.85, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      basePaint,
    );

    // 2. Draw a central glow that pulses (breathes) in intensity and size
    // It doesn't scroll/travel; it stays in the center.
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    // Glowing line section in the center
    final double glowWidth = size.width * 0.3; // Covers 30% of the center width
    final double startX = centerX - (glowWidth / 2);
    final double endX = centerX + (glowWidth / 2);

    // Pulse opacity between 0.2 and 0.85
    final double glowOpacity = 0.2 + (0.65 * pulse);

    final Paint glowLinePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          color.withOpacity(0.0),
          color.withOpacity(glowOpacity),
          color.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTRB(startX, 0, endX, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height * 1.5;

    canvas.drawLine(
      Offset(startX, centerY),
      Offset(endX, centerY),
      glowLinePaint,
    );

    // 3. Draw a tiny pulsing center dot
    final Paint dotPaint = Paint()
      ..color = color.withOpacity(0.4 + 0.6 * pulse)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(Offset(centerX, centerY), 1.5 + (0.5 * pulse), dotPaint);

    // 4. Draw a soft radial glow in the center that expands and contracts
    final double glowRadius = 8.0 + (6.0 * pulse);
    final Paint radialGlowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withOpacity(0.35 * pulse),
          color.withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: glowRadius))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(centerX, centerY), glowRadius, radialGlowPaint);
  }

  @override
  bool shouldRepaint(covariant _DividerPainter oldDelegate) {
    return oldDelegate.pulse != pulse ||
        oldDelegate.color != color ||
        oldDelegate.baseColor != baseColor;
  }
}
