import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/scroll_reveal.dart';
import 'package:get/get.dart';
import '../data/theme_config.dart';
import '../widgets/section_header.dart';
import '../widgets/custom_card.dart';
import '../controllers/skills_controller.dart';

class SkillsSection extends GetView<SkillsController> {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 1024;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          Text(
            "4+ years of building high-performance cross-platform applications, with Flutter at the core of my technical ecosystem.",
            style: TextStyle(
              fontSize: 16,
              color: ThemeConfig.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 48),
          
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ScrollReveal(
                  direction: RevealDirection.up,
                  delay: Duration.zero,
                  child: CustomCard(
                    padding: EdgeInsets.zero,
                    child: _buildCoreExpertiseCard(isMobile: true),
                  ),
                ),
                const SizedBox(height: 24),
                ScrollReveal(
                  direction: RevealDirection.up,
                  delay: const Duration(milliseconds: 100),
                  child: CustomCard(
                    padding: EdgeInsets.zero,
                    child: _buildStateManagementCard(),
                  ),
                ),
                const SizedBox(height: 24),
                ScrollReveal(
                  direction: RevealDirection.up,
                  delay: const Duration(milliseconds: 200),
                  child: CustomCard(
                    padding: EdgeInsets.zero,
                    child: _buildPowerhouseIntegrationsCard(isMobile: true),
                  ),
                ),
                const SizedBox(height: 24),
                ScrollReveal(
                  direction: RevealDirection.up,
                  delay: const Duration(milliseconds: 300),
                  child: CustomCard(
                    padding: EdgeInsets.zero,
                    child: _buildWebAndEcommerceCard(),
                  ),
                ),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      ScrollReveal(
                        direction: RevealDirection.left,
                        delay: Duration.zero,
                        child: CustomCard(
                          padding: EdgeInsets.zero,
                          child: _buildCoreExpertiseCard(isMobile: false),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ScrollReveal(
                        direction: RevealDirection.left,
                        delay: const Duration(milliseconds: 100),
                        child: CustomCard(
                          padding: EdgeInsets.zero,
                          child: _buildPowerhouseIntegrationsCard(isMobile: false),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      ScrollReveal(
                        direction: RevealDirection.right,
                        delay: Duration.zero,
                        child: CustomCard(
                          padding: EdgeInsets.zero,
                          child: _buildStateManagementCard(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ScrollReveal(
                        direction: RevealDirection.right,
                        delay: const Duration(milliseconds: 100),
                        child: CustomCard(
                          padding: EdgeInsets.zero,
                          child: _buildWebAndEcommerceCard(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCoreExpertiseCard({required bool isMobile}) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeConfig.primary.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: ThemeConfig.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ThemeConfig.primary.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  "PRIMARY STACK",
                  style: TextStyle(
                    color: ThemeConfig.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    fontFamily: "JetBrains Mono",
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Flutter & Dart",
                style: TextStyle(
                  color: ThemeConfig.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCoreSubItem("Architecture", "Clean Architecture, SOLID, Widget Composition"),
                const SizedBox(height: 20),
                _buildCoreSubItem("Performance", "Memory Management, Rendering Optimization, Isolate"),
                const SizedBox(height: 20),
                _buildCoreSubItem("Native Bridge", "Method Channels, Java/Kotlin, GoLang Integration"),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildCoreSubItem("Architecture", "Clean Architecture, SOLID, Widget Composition"),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildCoreSubItem("Performance", "Memory Management, Rendering Optimization, Isolate"),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildCoreSubItem("Native Bridge", "Method Channels, Java/Kotlin, GoLang Integration"),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCoreSubItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: ThemeConfig.primary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: "JetBrains Mono",
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            color: ThemeConfig.textSecondary,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStateManagementCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeConfig.outlineVariant.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "State Management",
            style: TextStyle(
              color: ThemeConfig.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _Badge(text: "GetX"),
              _Badge(text: "Riverpod"),
              _Badge(text: "BLoC"),
              _Badge(text: "Provider"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPowerhouseIntegrationsCard({required bool isMobile}) {
    return Obx(() {
      final showAll = controller.showAll.value;
      final currentDisplayList = controller.currentDisplayList;
      final tileTriggers = controller.tileTriggers;

      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: ThemeConfig.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: ThemeConfig.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isMobile
                ? Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Text(
                        "Powerhouse Integrations",
                        style: TextStyle(
                          color: ThemeConfig.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!showAll) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: ThemeConfig.primary.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: ThemeConfig.primary.withValues(alpha: 0.2)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.sync_alt, color: ThemeConfig.primary, size: 10),
                                  const SizedBox(width: 4),
                                  Text(
                                    "AUTO CYCLING",
                                    style: TextStyle(
                                      color: ThemeConfig.primary.withValues(alpha: 0.8),
                                      fontSize: 8,
                                      fontFamily: "JetBrains Mono",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: controller.toggleShowAll,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: ThemeConfig.surfaceContainerHigh,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: ThemeConfig.primary.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      showAll ? Icons.terminal : Icons.lock_open,
                                      color: ThemeConfig.primary,
                                      size: 10,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      showAll ? "COMPACT" : "DECRYPT ALL",
                                      style: TextStyle(
                                        color: ThemeConfig.primary,
                                        fontSize: 9,
                                        fontFamily: "JetBrains Mono",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Powerhouse Integrations",
                        style: TextStyle(
                          color: ThemeConfig.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!showAll) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: ThemeConfig.primary.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: ThemeConfig.primary.withValues(alpha: 0.2)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.sync_alt, color: ThemeConfig.primary, size: 10),
                                  const SizedBox(width: 4),
                                  Text(
                                    "AUTO CYCLING",
                                    style: TextStyle(
                                      color: ThemeConfig.primary.withValues(alpha: 0.8),
                                      fontSize: 8,
                                      fontFamily: "JetBrains Mono",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: controller.toggleShowAll,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: ThemeConfig.surfaceContainerHigh,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: ThemeConfig.primary.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      showAll ? Icons.terminal : Icons.lock_open,
                                      color: ThemeConfig.primary,
                                      size: 10,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      showAll ? "COMPACT" : "DECRYPT ALL",
                                      style: TextStyle(
                                        color: ThemeConfig.primary,
                                        fontSize: 9,
                                        fontFamily: "JetBrains Mono",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            const SizedBox(height: 32),
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 2 : 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.6,
              ),
              itemCount: currentDisplayList.length,
              itemBuilder: (context, index) {
                final item = currentDisplayList[index];
                return _IntegrationTile(
                  key: ValueKey<int>(index),
                  icon: item.icon,
                  label: item.title,
                  triggerDecrypt: tileTriggers[index],
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWebAndEcommerceCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeConfig.outlineVariant.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Web & E-commerce",
            style: TextStyle(
              color: ThemeConfig.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          
          _buildWebRow(Icons.web, "Framer", "High-fidelity Web Design"),
          const SizedBox(height: 16),
          _buildWebRow(Icons.shopping_cart, "Shopify", "Hydrogen & Liquid"),
        ],
      ),
    );
  }

  Widget _buildWebRow(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: ThemeConfig.primary,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: ThemeConfig.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: ThemeConfig.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SectionHeader(
      title: "Skills & Tech",
      subtitle: "My Toolbelt",
      index: "02",
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  const _Badge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeConfig.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: ThemeConfig.textPrimary,
          fontSize: 13,
          fontFamily: "JetBrains Mono",
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _IntegrationTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool triggerDecrypt;

  const _IntegrationTile({
    super.key,
    required this.icon,
    required this.label,
    required this.triggerDecrypt,
  });

  @override
  State<_IntegrationTile> createState() => _IntegrationTileState();
}

class _IntegrationTileState extends State<_IntegrationTile> {
  late String _displayedLabel;
  late IconData _displayedIcon;
  bool _isDecrypting = false;

  @override
  void initState() {
    super.initState();
    _displayedLabel = widget.label;
    _displayedIcon = widget.icon;
  }

  @override
  void didUpdateWidget(covariant _IntegrationTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.label != widget.label || widget.triggerDecrypt != oldWidget.triggerDecrypt) {
      _startDecryptAnimation();
    }
  }

  void _startDecryptAnimation() async {
    if (_isDecrypting) return;
    setState(() {
      _isDecrypting = true;
    });

    final String chars = "01#\$@&*?!%XYΩZ";
    final List<IconData> randomIcons = [
      Icons.lock,
      Icons.lock_open,
      Icons.security,
      Icons.code,
      Icons.terminal,
      Icons.settings_ethernet,
    ];
    final int steps = 8;
    
    for (int i = 0; i < steps; i++) {
      await Future.delayed(const Duration(milliseconds: 60));
      if (!mounted) return;
      setState(() {
        _displayedLabel = List.generate(
          widget.label.length,
          (index) => chars[(index + i + Random().nextInt(5)) % chars.length],
        ).join();
        _displayedIcon = randomIcons[i % randomIcons.length];
      });
    }

    if (!mounted) return;
    setState(() {
      _displayedLabel = widget.label;
      _displayedIcon = widget.icon;
      _isDecrypting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isDecrypting
              ? ThemeConfig.primary
              : ThemeConfig.outlineVariant.withValues(alpha: 0.2),
          width: _isDecrypting ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _displayedIcon,
            color: _isDecrypting ? ThemeConfig.primary : ThemeConfig.primary.withValues(alpha: 0.9),
            size: 20,
          ),
          const SizedBox(height: 8),
          Text(
            _displayedLabel,
            style: TextStyle(
              color: _isDecrypting ? ThemeConfig.primary : ThemeConfig.textSecondary,
              fontSize: 11,
              fontFamily: "JetBrains Mono",
              fontWeight: _isDecrypting ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
