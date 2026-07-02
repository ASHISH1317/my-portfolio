import 'package:flutter/material.dart';
import '../data/theme_config.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeConfig.background,
    );
  }
}
