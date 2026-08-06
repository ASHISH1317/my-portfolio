import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/custom_card.dart';
import '../widgets/section_header.dart';
import '../widgets/scroll_reveal.dart';

class PackagesSection extends StatelessWidget {
  const PackagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PackageData> packages = PortfolioData.packages;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: "Flutter Packages",
            subtitle: "Open Source",
            index: "04",
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final double maxWidth = constraints.maxWidth;
              // Responsive grid columns: 1 on mobile, 2 on desktop/tablet
              final int columns = maxWidth < 950 ? 1 : 2;
              const double spacing = 24.0;
              final double cardWidth =
                  (maxWidth - (columns - 1) * spacing) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: List.generate(packages.length, (index) {
                  final package = packages[index];
                  return SizedBox(
                    width: cardWidth,
                    child: ScrollReveal(
                      direction: RevealDirection.up,
                      delay: Duration(milliseconds: index * 100),
                      child: PackageCard(package: package),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PackageCard extends StatefulWidget {
  final PackageData package;
  const PackageCard({super.key, required this.package});

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  bool _isCopied = false;

  void _copyToClipboard(String command) {
    Clipboard.setData(ClipboardData(text: command));
    setState(() => _isCopied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isCopied = false);
      }
    });
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      glowColor: ThemeConfig.primary,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Pub Icon link
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.package.title,
                    style: ThemeConfig.h3.copyWith(
                      fontFamily: "JetBrains Mono",
                      color: ThemeConfig.textPrimary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _launchUrl(widget.package.pubUrl),
                  icon: Icon(
                    Icons.open_in_new_rounded,
                    color: ThemeConfig.primary,
                    size: 20,
                  ),
                  tooltip: "View on pub.dev",
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Install command CLI chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: ThemeConfig.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: ThemeConfig.outlineVariant.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.terminal_rounded,
                    color: ThemeConfig.primary,
                    size: 14,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.package.installCommand,
                      style: TextStyle(
                        fontFamily: "JetBrains Mono",
                        fontSize: 12,
                        color: ThemeConfig.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  InkWell(
                    onTap: () => _copyToClipboard(widget.package.installCommand),
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: _isCopied
                            ? const Icon(
                                Icons.check_circle_outline_rounded,
                                color: Colors.green,
                                size: 16,
                                key: ValueKey("copied"),
                              )
                            : Icon(
                                Icons.copy_all_rounded,
                                color: ThemeConfig.textMuted,
                                size: 16,
                                key: const ValueKey("copy"),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Description
            Text(
              widget.package.description,
              style: ThemeConfig.body.copyWith(
                fontSize: 14,
                color: ThemeConfig.textSecondary,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            // Highlights / Features checklist
            ...widget.package.keyHighlights.map((feature) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      color: ThemeConfig.primary,
                      size: 14,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: ThemeConfig.body.copyWith(
                          fontSize: 12,
                          color: ThemeConfig.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),
            // Hover-Animated Tags / Chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.package.tags.map((tag) {
                return HoverChip(label: tag);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// HoverChip Widget with micro-animations
class HoverChip extends StatefulWidget {
  final String label;
  const HoverChip({super.key, required this.label});

  @override
  State<HoverChip> createState() => _HoverChipState();
}

class _HoverChipState extends State<HoverChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: _isHovered ? ThemeConfig.primary.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: _isHovered ? ThemeConfig.primary : ThemeConfig.outlineVariant.withOpacity(0.5),
            width: 1,
          ),
        ),
        transform: _isHovered ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(),
        child: Text(
          widget.label,
          style: TextStyle(
            color: _isHovered ? ThemeConfig.primary : ThemeConfig.textSecondary,
            fontSize: 10,
            fontFamily: "JetBrains Mono",
            fontWeight: _isHovered ? FontWeight.bold : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
