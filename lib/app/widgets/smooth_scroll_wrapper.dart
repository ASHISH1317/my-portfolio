import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SmoothScrollWrapper extends StatefulWidget {
  final ScrollController controller;
  final Widget child;
  final double scrollSpeed;
  final int animationDuration;
  final Curve curve;

  const SmoothScrollWrapper({
    super.key,
    required this.controller,
    required this.child,
    this.scrollSpeed = 1.0,
    this.animationDuration = 250,
    this.curve = Curves.easeOutQuart,
  });

  @override
  State<SmoothScrollWrapper> createState() => _SmoothScrollWrapperState();
}

class _SmoothScrollWrapperState extends State<SmoothScrollWrapper> {
  double _targetOffset = 0.0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.controller.hasClients) {
        _targetOffset = widget.controller.position.pixels;
      }
    });
  }

  void _handleScrollSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      if (!widget.controller.hasClients) return;

      // Register the event with the pointer signal resolver to consume it
      // so that nested scrollables/default scrolling logic doesn't process it.
      GestureBinding.instance.pointerSignalResolver.register(event, (PointerSignalEvent resolvedEvent) {
        final pointerScrollEvent = resolvedEvent as PointerScrollEvent;
        final double maxScroll = widget.controller.position.maxScrollExtent;
        final double minScroll = widget.controller.position.minScrollExtent;

        // Reset target offset to match current scroll position if we weren't animating
        // (e.g. if the user scrolled by dragging or another controller moved it)
        if (!_isAnimating) {
          _targetOffset = widget.controller.position.pixels;
        }

        // Calculate and clamp target scroll offset
        _targetOffset += pointerScrollEvent.scrollDelta.dy * widget.scrollSpeed;
        _targetOffset = _targetOffset.clamp(minScroll, maxScroll);

        _isAnimating = true;
        widget.controller
            .animateTo(
              _targetOffset,
              duration: Duration(milliseconds: widget.animationDuration),
              curve: widget.curve,
            )
            .then((_) {
              _isAnimating = false;
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Enable custom smooth scroll wheel only on Desktop/Web
    final bool useSmoothScroll = kIsWeb ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux;

    if (!useSmoothScroll) {
      return widget.child;
    }

    return Listener(
      onPointerSignal: _handleScrollSignal,
      child: widget.child,
    );
  }
}
