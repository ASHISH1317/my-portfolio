import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/theme_config.dart';

class ScrollProgressIndicator extends StatelessWidget {
  final ScrollController scrollController;

  const ScrollProgressIndicator({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        double progress = 0.0;
        if (scrollController.hasClients &&
            scrollController.position.hasContentDimensions &&
            scrollController.position.maxScrollExtent > 0) {
          progress = (scrollController.offset / scrollController.position.maxScrollExtent)
              .clamp(0.0, 1.0);
        }

        return Obx(() => Container(
          height: 3.5,
          width: double.infinity,
          color: ThemeConfig.surfaceContainerLow,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: ThemeConfig.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: ThemeConfig.primary.withValues(alpha: 0.6),
                      blurRadius: 6,
                      spreadRadius: 1,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
      },
    );
  }
}
