import 'package:flutter/foundation.dart';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/theme_selector.dart';
import '../widgets/story_dialog.dart';

class Footer extends StatelessWidget {
  final Function(int)? onNavItemTap;

  const Footer({
    super.key,
    this.onNavItemTap,
  });

  Future<void> _launchURL(String urlString) async {
    if (kIsWeb) {
      html.window.open(urlString, '_blank');
    } else {
      final Uri url = Uri.parse(urlString);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        debugPrint("Could not launch $urlString");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 1150;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 48, bottom: 88),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            ThemeConfig.background.withValues(alpha: 0.4),
            ThemeConfig.background,
            ThemeConfig.background.withValues(alpha: 0.4),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1280),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              isMobile
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildBrandInfo(isMobile: true),
                        const SizedBox(height: 24),
                        _buildLinks(),
                        const SizedBox(height: 24),
                        const ThemeSelector(),
                        const SizedBox(height: 24),
                        _buildSocials(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildBrandInfo(isMobile: false),
                        _buildLinks(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const ThemeSelector(),
                            const SizedBox(width: 24),
                            _buildSocials(),
                          ],
                        ),
                      ],
                    ),
              const SizedBox(height: 32),
              _buildStoryButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandInfo({required bool isMobile}) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "<ashish.dev />",
          style: TextStyle(
            color: ThemeConfig.textPrimary,
            fontFamily: "JetBrains Mono",
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "© 2026 ${PortfolioData.fullName}. Made with ",
              style: TextStyle(
                color: ThemeConfig.textMuted,
                fontSize: 12,
              ),
            ),
            const PumpingHeart(),
            Text(
              " Flutter",
              style: TextStyle(
                color: ThemeConfig.textMuted,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStoryButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => FlutterStoryDialog.show(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: ThemeConfig.surfaceContainerLow,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: ThemeConfig.primary.withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: ThemeConfig.primary.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                size: 16,
                color: ThemeConfig.primary,
              ),
              const SizedBox(width: 10),
              Text(
                "My Chaotic Flutter Story 😂",
                style: TextStyle(
                  color: ThemeConfig.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLinks() {
    final links = ["About", "Skills", "Experience", "Packages", "Projects", "Education", "Contact"];
    return Wrap(
      spacing: 24,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: List.generate(links.length, (index) {
        final title = links[index];
        return FooterLink(
          title: title,
          onTap: () {
            if (onNavItemTap != null) {
              onNavItemTap!(index + 1);
            }
          },
        );
      }),
    );
  }

  Widget _buildSocials() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FooterSocialButton(
          icon: FontAwesomeIcons.github,
          onTap: () => _launchURL(PortfolioData.github1),
        ),
        const SizedBox(width: 12),
        FooterSocialButton(
          icon: FontAwesomeIcons.github,
          onTap: () => _launchURL(PortfolioData.github2),
        ),
        const SizedBox(width: 12),
        FooterSocialButton(
          icon: FontAwesomeIcons.linkedin,
          onTap: () => _launchURL(PortfolioData.linkedin),
        ),
        const SizedBox(width: 12),
        FooterSocialButton(
          icon: FontAwesomeIcons.instagram,
          onTap: () => _launchURL(PortfolioData.instagram),
        ),
        const SizedBox(width: 12),
        FooterSocialButton(
          icon: FontAwesomeIcons.whatsapp,
          onTap: () => _launchURL(PortfolioData.whatsapp),
        ),
      ],
    );
  }
}

class FooterSocialButton extends StatefulWidget {
  final dynamic icon;
  final VoidCallback onTap;

  const FooterSocialButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  State<FooterSocialButton> createState() => _FooterSocialButtonState();
}

class _FooterSocialButtonState extends State<FooterSocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _isHovered ? ThemeConfig.primary.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered ? ThemeConfig.primary : ThemeConfig.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          child: Center(
            child: FaIcon(
              widget.icon,
              color: _isHovered ? ThemeConfig.primary : ThemeConfig.textMuted,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class FooterLink extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const FooterLink({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  State<FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: _isHovered ? ThemeConfig.primary : ThemeConfig.textMuted,
            fontSize: 13,
            fontFamily: "JetBrains Mono",
            fontWeight: _isHovered ? FontWeight.bold : FontWeight.normal,
          ),
          child: Text(widget.title),
        ),
      ),
    );
  }
}

// Stateful pumping heart micro-animation
class PumpingHeart extends StatefulWidget {
  const PumpingHeart({super.key});

  @override
  State<PumpingHeart> createState() => _PumpingHeartState();
}

class _PumpingHeartState extends State<PumpingHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Heartbeat period
    );

    // Heartbeat double-pump sequence
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.25)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.25, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.2)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 55, // Resting weight
      ),
    ]).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: const Icon(
        Icons.favorite,
        color: Colors.red,
        size: 13,
      ),
    );
  }
}
