import 'package:flutter/foundation.dart';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';

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
    final bool isMobile = width < 768;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      decoration: BoxDecoration(
        color: ThemeConfig.background,
        border: Border(
          top: BorderSide(
            color: ThemeConfig.outlineVariant.withOpacity(0.3),
            width: 1.5,
          ),
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1280),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: isMobile
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildBrandInfo(),
                    const SizedBox(height: 24),
                    _buildLinks(),
                    const SizedBox(height: 24),
                    _buildSocials(),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildBrandInfo(),
                    _buildLinks(),
                    _buildSocials(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildBrandInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "<ashish.dev />",
          style: TextStyle(
            color: ThemeConfig.textPrimary,
            fontFamily: "JetBrains Mono",
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "© 2024 ${PortfolioData.fullName}. Made with Flutter",
          style: const TextStyle(
            color: ThemeConfig.textMuted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildLinks() {
    final links = ["About", "Skills", "Experience", "Projects", "Education", "Contact"];
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
            color: _isHovered ? ThemeConfig.primary.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered ? ThemeConfig.primary : ThemeConfig.outlineVariant.withOpacity(0.3),
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
