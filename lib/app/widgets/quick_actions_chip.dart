import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../data/theme_config.dart';

class QuickActionsChip extends StatefulWidget {
  final ScrollController scrollController;

  const QuickActionsChip({
    super.key,
    required this.scrollController,
  });

  @override
  State<QuickActionsChip> createState() => _QuickActionsChipState();
}

class _QuickActionsChipState extends State<QuickActionsChip> {
  bool _isHovered = false;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.scrollController,
      builder: (context, child) {
        double offset = 0.0;
        double maxScroll = 1.0;
        if (widget.scrollController.hasClients && widget.scrollController.position.hasContentDimensions) {
          offset = widget.scrollController.offset;
          maxScroll = widget.scrollController.position.maxScrollExtent > 0
              ? widget.scrollController.position.maxScrollExtent
              : 1.0;
        }

        final bool showScrollTop = offset > 400;
        final double progress = (offset / maxScroll).clamp(0.0, 1.0);

        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: Obx(() {
            final primaryColor = ThemeConfig.primary;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              transform: _isHovered
                  ? Matrix4.translationValues(0, -4, 0)
                  : Matrix4.identity(),
              decoration: BoxDecoration(
                color: _isHovered
                    ? ThemeConfig.surfaceContainerHigh.withValues(alpha: 0.95)
                    : ThemeConfig.surfaceContainerLow.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _isHovered
                      ? primaryColor.withValues(alpha: 0.6)
                      : primaryColor.withValues(alpha: 0.25),
                  width: _isHovered ? 1.5 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered
                        ? primaryColor.withValues(alpha: 0.25)
                        : Colors.black.withValues(alpha: 0.2),
                    blurRadius: _isHovered ? 20 : 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOutCubic,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Scroll to top button (animated entry)
                    if (showScrollTop) ...[
                      _buildScrollTopButton(progress),
                      _buildDivider(),
                    ],
                    // Quick contact section (animated height/content)
                    _buildContactSection(),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildScrollTopButton(double progress) {
    final primaryColor = ThemeConfig.primary;
    return Tooltip(
      message: "Scroll to Top",
      child: InkWell(
        onTap: () {
          if (widget.scrollController.hasClients) {
            widget.scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOutCubic,
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 1.5,
                  backgroundColor: primaryColor.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ),
              Icon(
                Icons.arrow_upward_rounded,
                color: primaryColor,
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        width: 16,
        height: 1,
        color: ThemeConfig.primary.withValues(alpha: 0.2),
      ),
    );
  }

  Widget _buildContactSection() {
    final primaryColor = ThemeConfig.primary;
    if (_isExpanded) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SocialLinkButton(
            icon: Icons.chat_bubble_outline_rounded,
            tooltip: "WhatsApp",
            brandColor: const Color(0xFF25D366),
            onTap: () => _launch(PortfolioData.whatsapp),
          ),
          const SizedBox(height: 6),
          _SocialLinkButton(
            icon: Icons.mail_outline_rounded,
            tooltip: "Email",
            brandColor: const Color(0xFFEA4335),
            onTap: () => _launch(PortfolioData.emailUrl),
          ),
          const SizedBox(height: 6),
          _SocialLinkButton(
            icon: Icons.code_rounded,
            tooltip: "GitHub",
            brandColor: ThemeConfig.textPrimary,
            onTap: () => _launch(PortfolioData.github1),
          ),
          const SizedBox(height: 6),
          _SocialLinkButton(
            icon: Icons.work_outline_rounded,
            tooltip: "LinkedIn",
            brandColor: const Color(0xFF0A66C2),
            onTap: () => _launch(PortfolioData.linkedin),
          ),
          const SizedBox(height: 8),
          // Close button
          Tooltip(
            message: "Close",
            child: InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = false;
                });
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.close_rounded,
                  size: 16,
                  color: ThemeConfig.textMuted,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Tooltip(
        message: "Quick Links",
        child: InkWell(
          onTap: () {
            setState(() {
              _isExpanded = true;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              Icons.link_rounded,
              size: 18,
              color: primaryColor,
            ),
          ),
        ),
      );
    }
  }

  Future<void> _launch(String url) async {
    if (url.isNotEmpty) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }
}

class _SocialLinkButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final Color brandColor;
  final VoidCallback onTap;

  const _SocialLinkButton({
    required this.icon,
    required this.tooltip,
    required this.brandColor,
    required this.onTap,
  });

  @override
  State<_SocialLinkButton> createState() => _SocialLinkButtonState();
}

class _SocialLinkButtonState extends State<_SocialLinkButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _isHovered
                  ? widget.brandColor.withValues(alpha: 0.15)
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered
                    ? widget.brandColor.withValues(alpha: 0.3)
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Icon(
              widget.icon,
              size: 16,
              color: _isHovered ? widget.brandColor : ThemeConfig.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
