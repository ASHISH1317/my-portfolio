import 'package:flutter/foundation.dart';
import 'dart:html' as html;
import 'package:flutter/material.dart' hide HeroController;
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/glowing_button.dart';
import '../widgets/cool_dialog.dart';
import '../controllers/hero_controller.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onContactPressed;
  final VoidCallback onWorkPressed;

  const HeroSection({
    super.key,
    required this.onContactPressed,
    required this.onWorkPressed,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  HeroController get controller => Get.find<HeroController>();
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideInAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack)),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 80,
      ),
      child: FadeTransition(
        opacity: _fadeInAnimation,
        child: SlideTransition(
          position: _slideInAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContent(isMobile: isMobile),
              const SizedBox(height: 80),
              _buildStatsGrid(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent({required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Available badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: ThemeConfig.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ThemeConfig.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: ThemeConfig.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "AVAILABLE FOR OPPORTUNITIES",
                style: TextStyle(
                  color: ThemeConfig.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  fontFamily: "JetBrains Mono",
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Title
        RichText(
          text: TextSpan(
            style: ThemeConfig.h1.copyWith(
              fontSize: isMobile ? 40 : 64,
              fontFamily: ThemeConfig.fontFamily,
            ),
            children: [
              const TextSpan(text: "Hi, I'm "),
              TextSpan(
                text: controller.name,
                style: TextStyle(color: ThemeConfig.primary),
              ),
              const TextSpan(text: "\nFlutter Developer"),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Subtitle
        Container(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            controller.heroSubTagline,
            style: ThemeConfig.bodyLarge.copyWith(
              fontSize: 18,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Location & Mail Info Row
        Wrap(
          spacing: 24,
          runSpacing: 8,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _showContactConfirm(
                  "Open Location",
                  "Do you want to view Surat, Gujarat, India on Google Maps?",
                  "https://www.google.com/maps/search/?api=1&query=Surat,+Gujarat,+India",
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on_outlined, color: ThemeConfig.textSecondary, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      controller.location,
                      style: TextStyle(color: ThemeConfig.textSecondary, fontFamily: "JetBrains Mono", fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            if (!isMobile)
              Text(
                "|",
                style: TextStyle(color: ThemeConfig.darkGray),
              ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _showContactConfirm(
                  "Send Email",
                  "Do you want to send an email to ${controller.email}?",
                  controller.emailUrl,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.mail_outlined, color: ThemeConfig.textSecondary, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      controller.email,
                      style: TextStyle(color: ThemeConfig.textSecondary, fontFamily: "JetBrains Mono", fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),
        // Buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            GlowingButton(
              text: "View My Work",
              icon: Icons.rocket_launch_rounded,
              onPressed: widget.onWorkPressed,
            ),
            GlowingButton(
              text: "Get In Touch",
              isSecondary: true,
              icon: Icons.mail_outline_rounded,
              onPressed: widget.onContactPressed,
            ),
          ],
        ),
      ],
    );
  }

  IconData _getStatIcon(int index) {
    switch (index) {
      case 0:
        return Icons.work_history_outlined;
      case 1:
        return Icons.rocket_launch_outlined;
      case 2:
        return Icons.code_rounded;
      case 3:
        return Icons.phone_iphone_outlined;
      default:
        return Icons.star_outline_rounded;
    }
  }

  Widget _buildStatsGrid(bool isMobile) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(top: 48),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ThemeConfig.outlineVariant.withOpacity(0.2),
            width: 2,
          ),
        ),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile ? 2 : 4,
          crossAxisSpacing: isMobile ? 16 : 24,
          mainAxisSpacing: isMobile ? 16 : 24,
          childAspectRatio: isMobile ? (width < 360 ? 1.6 : 2.0) : 2.6,
        ),
        itemCount: controller.stats.length,
        itemBuilder: (context, index) {
          final stat = controller.stats[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: ThemeConfig.surfaceContainerLow.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ThemeConfig.outlineVariant.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ThemeConfig.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: ThemeConfig.primary.withOpacity(0.15),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    _getStatIcon(index),
                    color: ThemeConfig.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        stat["value"] ?? "",
                        style: TextStyle(
                          color: ThemeConfig.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        stat["label"] ?? "",
                        style: TextStyle(
                          color: ThemeConfig.textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showContactConfirm(String title, String message, String actionUrl) {
    showCoolDialog(
      context: context,
      title: title,
      message: message,
      icon: Icons.open_in_new_rounded,
      accentColor: ThemeConfig.primary,
      primaryButtonText: "Yes",
      onPrimaryPressed: () {
        Navigator.of(context).pop();
        controller.launchURL(actionUrl);
      },
      secondaryButtonText: "Cancel",
      onSecondaryPressed: () => Navigator.of(context).pop(),
    );
  }
}
