import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/theme_config.dart';

enum _StarColorType { primary, secondary, white }

class _Star {
  final double x; // Local 3D coordinate X (scaled -0.5 to 0.5)
  final double y; // Local 3D coordinate Y (scaled -0.5 to 0.5)
  final double z; // Local 3D coordinate Z (scaled -0.5 to 0.5)
  final double radius;
  final int layer;
  final double speedX;
  final double speedY;
  final double speedZ;
  final double twinkleSpeed;
  final double twinklePhase;
  final double baseOpacity;
  final _StarColorType colorType;

  _Star({
    required this.x,
    required this.y,
    required this.z,
    required this.radius,
    required this.layer,
    required this.speedX,
    required this.speedY,
    required this.speedZ,
    required this.twinkleSpeed,
    required this.twinklePhase,
    required this.baseOpacity,
    required this.colorType,
  });
}

class _ShootingStar {
  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final double speed;
  final double length;
  final double opacity;
  double progress = 0.0;

  _ShootingStar({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.speed,
    required this.length,
    required this.opacity,
  });
}

class _Ripple {
  final Offset center;
  final double maxRadius;
  double currentRadius = 0.0;
  double opacity = 1.0;
  final double expansionSpeed;

  _Ripple({
    required this.center,
    required this.maxRadius,
    required this.expansionSpeed,
  });
}

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Star> _stars = [];
  final List<_ShootingStar> _shootingStars = [];
  final List<_Ripple> _ripples = [];
  final math.Random _random = math.Random();
  Offset? _mousePosition;
  late final Stopwatch _stopwatch;
  int _lastSpawnTimeMs = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _controller.addListener(_onTick);
    _stopwatch = Stopwatch()..start();
    _lastSpawnTimeMs = -3000; // Spawns the first shooting star after 2 seconds

    // Initialize stars (90 density for high-end feel while preserving CPU cycles)
    for (int i = 0; i < 90; i++) {
      int layer;
      if (i < 60) {
        layer = 0; // Far depth (rich backing canopy)
      } else if (i < 80) {
        layer = 1; // Mid depth (constellations)
      } else {
        layer = 2; // Near depth (glowing bright bodies)
      }

      double radius;
      double baseOpacity;
      if (layer == 0) {
        radius = _random.nextDouble() * 0.7 + 0.5;
        baseOpacity = _random.nextDouble() * 0.25 + 0.15;
      } else if (layer == 1) {
        radius = _random.nextDouble() * 1.0 + 1.2;
        baseOpacity = _random.nextDouble() * 0.3 + 0.4;
      } else {
        radius = _random.nextDouble() * 1.4 + 2.2;
        baseOpacity = _random.nextDouble() * 0.3 + 0.6;
      }

      final colorRand = _random.nextDouble();
      _StarColorType colorType;
      if (colorRand < 0.15) {
        colorType = _StarColorType.primary;
      } else if (colorRand < 0.25) {
        colorType = _StarColorType.secondary;
      } else {
        colorType = _StarColorType.white;
      }

      _stars.add(_Star(
        x: _random.nextDouble() - 0.5,
        y: _random.nextDouble() - 0.5,
        z: _random.nextDouble() - 0.5,
        radius: radius,
        layer: layer,
        speedX: (_random.nextDouble() - 0.5) * 0.03,
        speedY: (_random.nextDouble() - 0.5) * 0.03,
        speedZ: (_random.nextDouble() - 0.5) * 0.03,
        twinkleSpeed: _random.nextInt(4) + 2.0,
        twinklePhase: _random.nextDouble() * 2 * math.pi,
        baseOpacity: baseOpacity,
        colorType: colorType,
      ));
    }
  }

  void _onTick() {
    if (!mounted) return;
    _updateShootingStars();
    _updateRipples();
  }

  void _updateShootingStars() {
    // 1. Update existing shooting stars
    for (int i = _shootingStars.length - 1; i >= 0; i--) {
      final star = _shootingStars[i];
      star.progress += star.speed;
      if (star.progress >= 1.0) {
        _shootingStars.removeAt(i);
      }
    }

    // 2. Spawn a new shooting star every 5 seconds
    final elapsedMs = _stopwatch.elapsedMilliseconds;
    if (elapsedMs - _lastSpawnTimeMs >= 5000) {
      _lastSpawnTimeMs = elapsedMs;
      _spawnShootingStar();
    }
  }

  void _spawnShootingStar() {
    // Spawns a shooting star from one of 4 different paths/edges
    final pathType = _random.nextInt(4);
    double startX, startY, endX, endY;

    switch (pathType) {
      case 0:
        // Top edge, moving diagonally downwards to the right
        startX = _random.nextDouble() * 0.5; // left half of top edge
        startY = 0.0;
        endX = startX + 0.3 + _random.nextDouble() * 0.2;
        endY = 0.6 + _random.nextDouble() * 0.4;
        break;
      case 1:
        // Top edge, moving diagonally downwards to the left
        startX = 0.5 + _random.nextDouble() * 0.5; // right half of top edge
        startY = 0.0;
        endX = startX - 0.3 - _random.nextDouble() * 0.2;
        endY = 0.6 + _random.nextDouble() * 0.4;
        break;
      case 2:
        // Left edge, moving diagonally downwards to the right
        startX = 0.0;
        startY = 0.1 + _random.nextDouble() * 0.4; // upper half of left edge
        endX = 0.7 + _random.nextDouble() * 0.3;
        endY = startY + 0.3 + _random.nextDouble() * 0.2;
        break;
      case 3:
      default:
        // Right edge, moving diagonally downwards to the left
        startX = 1.0;
        startY = 0.1 + _random.nextDouble() * 0.4; // upper half of right edge
        endX = 0.0 + _random.nextDouble() * 0.3;
        endY = startY + 0.3 + _random.nextDouble() * 0.2;
        break;
    }

    _shootingStars.add(_ShootingStar(
      startX: startX,
      startY: startY,
      endX: endX,
      endY: endY,
      speed: 0.012 + _random.nextDouble() * 0.008, // slightly slower for better visibility
      length: 0.07 + _random.nextDouble() * 0.05,
      opacity: _random.nextDouble() * 0.4 + 0.6,
    ));
  }

  void _updateRipples() {
    for (int i = _ripples.length - 1; i >= 0; i--) {
      final ripple = _ripples[i];
      ripple.currentRadius += ripple.expansionSpeed;
      ripple.opacity = 1.0 - (ripple.currentRadius / ripple.maxRadius);
      if (ripple.currentRadius >= ripple.maxRadius) {
        _ripples.removeAt(i);
      }
    }
  }

  void _spawnRipple(Offset position) {
    setState(() {
      _ripples.add(_Ripple(
        center: position,
        maxRadius: 280.0,
        expansionSpeed: 8.0,
      ));
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onTick);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final primaryColor = ThemeConfig.primary;
      final secondaryColor = ThemeConfig.secondary;
      final bgColor = ThemeConfig.background;

      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (details) {
          _spawnRipple(details.localPosition);
        },
        child: MouseRegion(
          onHover: (event) {
            setState(() {
              _mousePosition = event.localPosition;
            });
          },
          onExit: (event) {
            setState(() {
              _mousePosition = null;
            });
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _BackgroundPainter(
                  time: _stopwatch.elapsedMicroseconds / 1000000.0,
                  stars: _stars,
                  shootingStars: List.from(_shootingStars),
                  ripples: List.from(_ripples),
                  mousePosition: _mousePosition,
                  primaryColor: primaryColor,
                  secondaryColor: secondaryColor,
                  backgroundColor: bgColor,
                ),
                child: Container(),
              );
            },
          ),
        ),
      );
    });
  }
}

class _ProjectedStar {
  final Offset position;
  final double scale;
  final double depthZ;
  final double rx;
  final double ry;
  final double rz;

  _ProjectedStar({
    required this.position,
    required this.scale,
    required this.depthZ,
    required this.rx,
    required this.ry,
    required this.rz,
  });
}

class _BackgroundPainter extends CustomPainter {
  final double time;
  final List<_Star> stars;
  final List<_ShootingStar> shootingStars;
  final List<_Ripple> ripples;
  final Offset? mousePosition;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;

  _BackgroundPainter({
    required this.time,
    required this.stars,
    required this.shootingStars,
    required this.ripples,
    required this.mousePosition,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double progress = time / 20.0;
    // 1. Draw space theme background
    final bgPaint = Paint()..color = backgroundColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Calculate Mouse input coordinates
    double mouseXNormalized = 0.5;
    double mouseYNormalized = 0.5;
    if (mousePosition != null && size.width > 0 && size.height > 0) {
      mouseXNormalized = mousePosition!.dx / size.width;
      mouseYNormalized = mousePosition!.dy / size.height;
    }

    // Camera 3D tilts (with mouse interactive 4D parallax shift)
    final tiltX = (mouseYNormalized - 0.5) * 0.35;
    final tiltY = (mouseXNormalized - 0.5) * 0.35;

    // 2. Draw drifting, breathing cosmic nebulae (with interactive parallax)
    final double mouseShiftX = (mouseXNormalized - 0.5) * 60.0;
    final double mouseShiftY = (mouseYNormalized - 0.5) * 60.0;

    final nebula1Center = Offset(
      size.width * 0.25 + math.sin(progress * 2 * math.pi) * 120 - mouseShiftX * 0.5,
      size.height * 0.35 + math.sin(progress * 4 * math.pi) * 60 - mouseShiftY * 0.5,
    );
    final nebula2Center = Offset(
      size.width * 0.75 + math.cos(progress * 2 * math.pi) * 100 - mouseShiftX * 0.3,
      size.height * 0.65 - math.sin(progress * 2 * math.pi) * 80 - mouseShiftY * 0.3,
    );
    final nebula3Center = Offset(
      size.width * 0.45 + math.cos(progress * 2 * math.pi + math.pi/4) * 70 - mouseShiftX * 0.4,
      size.height * 0.5 + math.sin(progress * 2 * math.pi) * 50 - mouseShiftY * 0.4,
    );

    final orbPaint1 = Paint()
      ..shader = RadialGradient(
        colors: [
          primaryColor.withValues(alpha: 0.16),
          primaryColor.withValues(alpha: 0.05),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: nebula1Center, radius: size.width * 0.45));

    final orbPaint2 = Paint()
      ..shader = RadialGradient(
        colors: [
          secondaryColor.withValues(alpha: 0.12),
          secondaryColor.withValues(alpha: 0.03),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: nebula2Center, radius: size.width * 0.50));

    final orbPaint3 = Paint()
      ..shader = RadialGradient(
        colors: [
          primaryColor.withValues(alpha: 0.08),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: nebula3Center, radius: size.width * 0.35));

    canvas.drawCircle(nebula1Center, size.width * 0.45, orbPaint1);
    canvas.drawCircle(nebula2Center, size.width * 0.50, orbPaint2);
    canvas.drawCircle(nebula3Center, size.width * 0.35, orbPaint3);

    // 3. Project 3D coordinates of all stars
    final projected = List<_ProjectedStar>.generate(stars.length, (i) {
      final star = stars[i];

      // Slow time-based drift
      double speedMultiplier = star.layer == 0 ? 0.15 : (star.layer == 1 ? 0.4 : 0.8);
      double lx = star.x + star.speedX * progress * speedMultiplier;
      double ly = star.y + star.speedY * progress * speedMultiplier;
      double lz = star.z + star.speedZ * progress * speedMultiplier;

      // Wrap local positions to keep stars in bounding box [-0.6, 0.6]
      lx = (lx + 0.6) % 1.2; if (lx < 0) lx += 1.2; lx -= 0.6;
      ly = (ly + 0.6) % 1.2; if (ly < 0) ly += 1.2; ly -= 0.6;
      lz = (lz + 0.6) % 1.2; if (lz < 0) lz += 1.2; lz -= 0.6;

      // Continuous 3D rotation (around Y and X axes)
      final rotAngleY = progress * 0.12 * math.pi;
      final rotAngleX = progress * 0.06 * math.pi;

      // Rotate around X axis
      double x1 = lx;
      double y1 = ly * math.cos(rotAngleX) - lz * math.sin(rotAngleX);
      double z1 = ly * math.sin(rotAngleX) + lz * math.cos(rotAngleX);

      // Rotate around Y axis
      double x2 = x1 * math.cos(rotAngleY) + z1 * math.sin(rotAngleY);
      double y2 = y1;
      double z2 = -x1 * math.sin(rotAngleY) + z1 * math.cos(rotAngleY);

      // Apply interactive camera tilt (tiltX, tiltY)
      double rx = x2;
      double ry = y2 * math.cos(tiltX) - z2 * math.sin(tiltX);
      double rz = y2 * math.sin(tiltX) + z2 * math.cos(tiltX);

      double rx2 = rx * math.cos(tiltY) + rz * math.sin(tiltY);
      double ry2 = ry;
      double rz2 = -rx * math.sin(tiltY) + rz * math.cos(tiltY);

      // Perspective projection (camera distance d = 1.0)
      const cameraDistance = 1.0;
      double scale = cameraDistance / (cameraDistance + rz2);

      final centerX = size.width * 0.5;
      final centerY = size.height * 0.5;

      // Projected screen position
      double px = centerX + rx2 * scale * size.width * 1.15;
      double py = centerY + ry2 * scale * size.height * 1.15;

      Offset pos = Offset(px, py);

      // Apply interactive Mouse Gravity
      if (mousePosition != null) {
        final distVec = pos - mousePosition!;
        final distance = distVec.distance;
        const maxGravityDistance = 150.0;
        if (distance < maxGravityDistance) {
          double interactionStrength = star.layer == 0 ? 4.0 : (star.layer == 1 ? 12.0 : 24.0);
          final force = (1.0 - (distance / maxGravityDistance)) * interactionStrength;
          final direction = distVec.direction;
          pos += Offset(math.cos(direction) * force, math.sin(direction) * force);
        }
      }

      // Apply Click Ripple Displacement (shockwaves)
      for (var ripple in ripples) {
        final distVec = pos - ripple.center;
        final distance = distVec.distance;
        
        const waveWidth = 60.0;
        final distFromWaveFront = (distance - ripple.currentRadius).abs();
        if (distFromWaveFront < waveWidth && distance > 10.0) {
          final waveFactor = 1.0 - (distFromWaveFront / waveWidth);
          final decayFactor = ripple.opacity;
          
          double basePush = star.layer == 0 ? 8.0 : (star.layer == 1 ? 25.0 : 50.0);
          final pushForce = waveFactor * decayFactor * basePush;
          
          final direction = distVec.direction;
          pos += Offset(math.cos(direction) * pushForce, math.sin(direction) * pushForce);
        }
      }

      return _ProjectedStar(
        position: pos,
        scale: scale,
        depthZ: rz2,
        rx: x2,
        ry: y2,
        rz: z2,
      );
    });

    // 4. Draw Constellation lines between stars of the same layer based on 3D distance
    final linePaint = Paint()..strokeWidth = 0.5;
    for (int i = 0; i < stars.length; i++) {
      final s1 = stars[i];
      if (s1.layer == 0) continue; // Skip far stars for cleaner visuals

      final s1Proj = projected[i];

      for (int j = i + 1; j < stars.length; j++) {
        final s2 = stars[j];
        if (s1.layer != s2.layer) continue;

        final s2Proj = projected[j];
        
        // Compute distance in 3D space to maintain stable network connections during rotation
        final dx = s1Proj.rx - s2Proj.rx;
        final dy = s1Proj.ry - s2Proj.ry;
        final dz = s1Proj.rz - s2Proj.rz;
        final dist3D = math.sqrt(dx*dx + dy*dy + dz*dz);

        const maxDist = 0.22;
        if (dist3D < maxDist) {
          final distOpacity = (1.0 - (dist3D / maxDist));
          final scaleFactor = (s1Proj.scale + s2Proj.scale) / 2.0;
          final opacity = distOpacity * 0.08 * (s1.baseOpacity + s2.baseOpacity) / 2.0 * scaleFactor;
          
          if (opacity > 0.005) {
            linePaint.color = primaryColor.withValues(alpha: opacity.clamp(0.0, 1.0));
            canvas.drawLine(s1Proj.position, s2Proj.position, linePaint);
          }
        }
      }
    }

    // 5. Draw interactive constellation lines to the mouse position
    if (mousePosition != null) {
      for (int i = 0; i < stars.length; i++) {
        final star = stars[i];
        if (star.layer == 0) continue;
        final sProj = projected[i];
        final dist = (sProj.position - mousePosition!).distance;
        if (dist < 120) {
          final opacity = (1.0 - (dist / 120)) * 0.12 * sProj.scale;
          linePaint.color = primaryColor.withValues(alpha: opacity.clamp(0.0, 1.0));
          canvas.drawLine(sProj.position, mousePosition!, linePaint);
        }
      }
    }

    // 6. Draw the Stars - Sorted by depth (furthest drawn first, closer drawn last)
    final starIndices = List.generate(stars.length, (i) => i);
    starIndices.sort((a, b) => projected[b].depthZ.compareTo(projected[a].depthZ));

    final starPaint = Paint();
    for (var index in starIndices) {
      final star = stars[index];
      final proj = projected[index];
      final pos = proj.position;

      // Twinkling effect: Calculate unique oscillating factor
      final twinkleFactor = (0.3 + 0.7 * math.sin(progress * 2 * math.pi * star.twinkleSpeed + star.twinklePhase).abs());
      
      final clampedScale = proj.scale.clamp(0.25, 2.5);
      final currentOpacity = star.baseOpacity * twinkleFactor * clampedScale;
      final currentRadius = star.radius * clampedScale;

      Color starColor;
      switch (star.colorType) {
        case _StarColorType.primary:
          starColor = primaryColor;
          break;
        case _StarColorType.secondary:
          starColor = secondaryColor;
          break;
        case _StarColorType.white:
          starColor = Colors.white;
          break;
      }

      // Add a subtle outer glow for near stars (layer 2)
      if (star.layer == 2) {
        final glowPaint = Paint()
          ..color = starColor.withValues(alpha: (currentOpacity * 0.3).clamp(0.0, 1.0))
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0);
        canvas.drawCircle(pos, currentRadius * 2.0, glowPaint);
      }

      starPaint.color = starColor.withValues(alpha: currentOpacity.clamp(0.0, 1.0));
      canvas.drawCircle(pos, currentRadius, starPaint);
    }

    // 7. Draw Shooting Stars
    for (var ss in shootingStars) {
      final currentProgress = ss.progress;
      final tailProgress = math.max(0.0, currentProgress - ss.length);

      final currentX = ss.startX + (ss.endX - ss.startX) * currentProgress;
      final currentY = ss.startY + (ss.endY - ss.startY) * currentProgress;

      final tailX = ss.startX + (ss.endX - ss.startX) * tailProgress;
      final tailY = ss.startY + (ss.endY - ss.startY) * tailProgress;

      final headPos = Offset(currentX * size.width, currentY * size.height);
      final tailPos = Offset(tailX * size.width, tailY * size.height);

      final lifeFade = 1.0 - currentProgress;
      final alpha = ss.opacity * lifeFade;

      final ssPaint = Paint()
        ..shader = ui.Gradient.linear(
          headPos,
          tailPos,
          [
            primaryColor.withValues(alpha: alpha),
            Colors.transparent,
          ],
        )
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(headPos, tailPos, ssPaint);

      // Draw a tiny bright center point for extra high-end feel
      final headPaint = Paint()
        ..color = Colors.white.withValues(alpha: alpha)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);
      canvas.drawCircle(headPos, 2.0, headPaint);
    }

    // 8. Draw click ripples (glowing expanding shockwaves)
    for (var ripple in ripples) {
      final ripplePaint = Paint()
        ..color = primaryColor.withValues(alpha: (ripple.opacity * 0.12).clamp(0.0, 1.0))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0 + (1.0 - ripple.opacity) * 6.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);
      canvas.drawCircle(ripple.center, ripple.currentRadius, ripplePaint);

      final sharpPaint = Paint()
        ..color = primaryColor.withValues(alpha: (ripple.opacity * 0.18).clamp(0.0, 1.0))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawCircle(ripple.center, ripple.currentRadius, sharpPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) => true;
}
