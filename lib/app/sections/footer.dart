import 'package:flutter/material.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

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
          "© 2024 ${PortfolioData.fullName}. Made with Emergent",
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
      children: links.map((title) {
        return Text(
          title,
          style: const TextStyle(
            color: ThemeConfig.textMuted,
            fontSize: 13,
            fontFamily: "JetBrains Mono",
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSocials() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialButton(Icons.code_rounded),
        const SizedBox(width: 12),
        _buildSocialButton(Icons.link_rounded),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ThemeConfig.outlineVariant.withOpacity(0.3),
        ),
      ),
      child: Icon(
        icon,
        color: ThemeConfig.textMuted,
        size: 18,
      ),
    );
  }
}
