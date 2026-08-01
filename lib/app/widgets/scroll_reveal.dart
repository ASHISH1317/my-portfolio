import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

enum RevealDirection { up, down, left, right, none }

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final RevealDirection direction;
  final Duration delay;
  final Duration duration;
  final double offset;
  final double scale;
  final Curve curve;

  const ScrollReveal({
    super.key,
    required this.child,
    this.direction = RevealDirection.up,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.offset = 0.15,
    this.scale = 1.0,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  bool _isVisible = false;
  late final Key _visibilityKey;

  @override
  void initState() {
    super.initState();
    _visibilityKey = UniqueKey();
  }

  @override
  Widget build(BuildContext context) {
    double dx = 0.0;
    double dy = 0.0;

    switch (widget.direction) {
      case RevealDirection.up:
        dy = widget.offset;
        break;
      case RevealDirection.down:
        dy = -widget.offset;
        break;
      case RevealDirection.left:
        dx = widget.offset;
        break;
      case RevealDirection.right:
        dx = -widget.offset;
        break;
      case RevealDirection.none:
        break;
    }

    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.08) {
          if (!mounted) return;
          if (!_isVisible) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      },
      child: widget.child
          .animate(target: _isVisible ? 1.0 : 0.0)
          .fadeIn(
            delay: widget.delay,
            duration: widget.duration,
            curve: widget.curve,
          )
          .slide(
            begin: Offset(dx, dy),
            end: Offset.zero,
            delay: widget.delay,
            duration: widget.duration,
            curve: widget.curve,
          )
          .scale(
            begin: Offset(widget.scale, widget.scale),
            end: const Offset(1.0, 1.0),
            delay: widget.delay,
            duration: widget.duration,
            curve: widget.curve,
          ),
    );
  }
}
