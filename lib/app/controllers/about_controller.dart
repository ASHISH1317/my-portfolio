import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/portfolio_data.dart';

class AboutController extends GetxController {
  final String aboutText1 = PortfolioData.aboutText1;
  final String aboutText2 = PortfolioData.aboutText2;
  final String aboutText3 = PortfolioData.aboutText3;
  
  final List<String> tags = const [
    "Flutter",
    "Dart",
    "Firebase",
    "REST APIs",
    "GetX",
    "Riverpod",
    "BLoC",
    "Provider",
    "Hive & SQLite",
    "Flutter Web",
    "Shopify",
    "Framer AI",
  ];

  final List<Map<String, dynamic>> highlights = const [
    {
      "title": "Scalable Architecture",
      "desc": "Architecting clean, modular, and testable codebases utilizing SOLID principles for future-proof scalability.",
      "icon": Icons.architecture_rounded,
    },
    {
      "title": "High Performance",
      "desc": "Crafting fluid, responsive interfaces running at 60/120 FPS with highly optimized state management.",
      "icon": Icons.speed_rounded,
    },
    {
      "title": "Robust Integrations",
      "desc": "Seamlessly connecting real-time WebSockets, enterprise IoT APIs, and secure payment systems.",
      "icon": Icons.hub_rounded,
    },
    {
      "title": "Engineering Leadership",
      "desc": "Leading agile development teams, mentoring junior engineers, and driving successful App Store deliveries.",
      "icon": Icons.psychology_rounded,
    },
  ];
}
