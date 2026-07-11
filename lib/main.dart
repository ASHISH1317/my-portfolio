import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/data/theme_config.dart';
import 'app/portfolio_home.dart';
import 'app/bindings/portfolio_binding.dart';
import 'app/widgets/smooth_scroll_behavior.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ashish | Portfolio',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const SmoothScrollBehavior(),
      initialBinding: PortfolioBinding(),
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: ThemeConfig.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ThemeConfig.primary,
          brightness: Brightness.dark,
          background: ThemeConfig.background,
          surface: ThemeConfig.surface,
        ),
        fontFamily: ThemeConfig.fontFamily,
      ),
      home: const PortfolioHome(),
    );
  }
}
