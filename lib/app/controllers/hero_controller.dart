import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import '../data/portfolio_data.dart';

class HeroController extends GetxController {
  final String name = PortfolioData.name;
  final String heroSubTagline = PortfolioData.heroSubTagline;
  final String location = PortfolioData.location;
  final String email = PortfolioData.email;
  final String emailUrl = PortfolioData.emailUrl;
  final List<Map<String, String>> stats = PortfolioData.stats;

  Future<void> launchURL(String urlString) async {
    if (kIsWeb) {
      html.window.open(urlString, '_blank');
    } else {
      final Uri url = Uri.parse(urlString);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        debugPrint("Could not launch $urlString");
      }
    }
  }
}
