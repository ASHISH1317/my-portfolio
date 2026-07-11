import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SmoothScrollBehavior extends MaterialScrollBehavior {
  const SmoothScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    // Enable bouncing physics for smooth elastic scrolling on all devices (mobile, web, desktop)
    return const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }
}
