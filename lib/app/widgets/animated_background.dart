import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/theme_config.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    for (int i = 0; i < 35; i++) {
      _particles.add(_Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        radius: _random.nextDouble() * 3 + 1.5,
        speedX: (_random.nextDouble() - 0.5) * 0.05,
        speedY: (_random.nextDouble() - 0.5) * 0.05,
        opacity: _random.nextDouble() * 0.5 + 0.2,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final primaryColor = ThemeConfig.primary;
      final secondaryColor = ThemeConfig.secondary;
      final bgColor = ThemeConfig.background;

      return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _BackgroundPainter(
              progress: _controller.value,
              particles: _particles,
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
              backgroundColor: bgColor,
            ),
            child: Container(),
          );
        },
      );
    });
  }
}

class _Particle {
  double x;
  double y;
  double radius;
  double speedX;
  double speedY;
  double opacity;

  _Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speedX,
    required this.speedY,
    required this.opacity,
  });
}

class _BackgroundPainter extends CustomPainter {
  final double progress;
  final List<_Particle> particles;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;

  _BackgroundPainter({
    required this.progress,
    required this.particles,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Solid theme background
    final bgPaint = Paint()..color = backgroundColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // 2. Ambient glowing color orbs
    final orb1Center = Offset(
      size.width * 0.2 + math.sin(progress * 2 * math.pi) * 80,
      size.height * 0.3 + math.cos(progress * 2 * math.pi) * 60,
    );
    final orb2Center = Offset(
      size.width * 0.8 - math.cos(progress * 2 * math.pi) * 90,
      size.height * 0.7 - math.sin(progress * 2 * math.pi) * 70,
    );

    final orbPaint1 = Paint()
      ..shader = RadialGradient(
        colors: [
          primaryColor.withValues(alpha: 0.15),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: orb1Center, radius: size.width * 0.4));

    final orbPaint2 = Paint()
      ..shader = RadialGradient(
        colors: [
          secondaryColor.withValues(alpha: 0.12),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: orb2Center, radius: size.width * 0.45));

    canvas.drawCircle(orb1Center, size.width * 0.4, orbPaint1);
    canvas.drawCircle(orb2Center, size.width * 0.45, orbPaint2);

    // 3. Floating Particles
    final particlePaint = Paint();
    for (var p in particles) {
      double currentX = (p.x + p.speedX * progress) % 1.0;
      double currentY = (p.y + p.speedY * progress) % 1.0;
      if (currentX < 0) currentX += 1.0;
      if (currentY < 0) currentY += 1.0;

      final dx = currentX * size.width;
      final dy = currentY * size.height;

      particlePaint.color = primaryColor.withValues(alpha: p.opacity * 0.6);
      canvas.drawCircle(Offset(dx, dy), p.radius, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) => true;
}
