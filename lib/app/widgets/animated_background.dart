import 'package:flutter/material.dart';
import '../data/theme_config.dart';

import 'package:get/get.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      color: ThemeConfig.background,
    ));
  }
}
