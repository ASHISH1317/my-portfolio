import 'package:flutter/material.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/glowing_button.dart';

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
                decoration: const BoxDecoration(
                  color: ThemeConfig.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
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
                text: PortfolioData.name,
                style: const TextStyle(color: ThemeConfig.primary),
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
            PortfolioData.heroSubTagline,
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_on_outlined, color: ThemeConfig.textSecondary, size: 18),
                const SizedBox(width: 6),
                Text(
                  PortfolioData.location,
                  style: const TextStyle(color: ThemeConfig.textSecondary, fontFamily: "JetBrains Mono", fontSize: 14),
                ),
              ],
            ),
            if (!isMobile)
              const Text(
                "|",
                style: TextStyle(color: ThemeConfig.darkGray),
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.mail_outlined, color: ThemeConfig.textSecondary, size: 18),
                const SizedBox(width: 6),
                Text(
                  PortfolioData.email,
                  style: const TextStyle(color: ThemeConfig.textSecondary, fontFamily: "JetBrains Mono", fontSize: 14),
                ),
              ],
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

  Widget _buildStatsGrid(bool isMobile) {
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
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: isMobile ? 1.4 : 1.7,
        ),
        itemCount: PortfolioData.stats.length,
        itemBuilder: (context, index) {
          final stat = PortfolioData.stats[index];
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: ThemeConfig.surfaceContainerLow.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: ThemeConfig.outlineVariant.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  stat["value"] ?? "",
                  style: const TextStyle(
                    color: ThemeConfig.primary,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  stat["label"] ?? "",
                  style: const TextStyle(
                    color: ThemeConfig.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
