import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../data/theme_config.dart';
import '../widgets/section_header.dart';

class IntegrationData {
  final String title;
  final IconData icon;

  const IntegrationData({required this.title, required this.icon});
}

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  final List<IntegrationData> _allIntegrations = const [
    IntegrationData(title: "Supabase", icon: Icons.storage),
    IntegrationData(title: "Firebase", icon: Icons.local_fire_department),
    IntegrationData(title: "AWS", icon: Icons.cloud),
    IntegrationData(title: "Google Maps", icon: Icons.map),
    IntegrationData(title: "Stripe", icon: Icons.payments),
    IntegrationData(title: "Razorpay", icon: Icons.account_balance_wallet),
    IntegrationData(title: "REST APIs", icon: Icons.api),
    IntegrationData(title: "GoLang", icon: Icons.terminal),
    IntegrationData(title: "Socket.IO", icon: Icons.sync),
    IntegrationData(title: "Push Alerts", icon: Icons.notifications_active),
    IntegrationData(title: "SQLite / Hive", icon: Icons.dns),
    IntegrationData(title: "Sentry / Crash", icon: Icons.bug_report),
    IntegrationData(title: "GraphQL", icon: Icons.hub),
    IntegrationData(title: "BLE Bluetooth", icon: Icons.bluetooth),
    IntegrationData(title: "CI/CD Pipelines", icon: Icons.build_circle),
    IntegrationData(title: "RevenueCat", icon: Icons.monetization_on),
    IntegrationData(title: "WebRTC", icon: Icons.videocam),
    IntegrationData(title: "Mapbox SDK", icon: Icons.explore),
    IntegrationData(title: "GetIt / Inject", icon: Icons.extension),
    IntegrationData(title: "OAuth 2.0", icon: Icons.vpn_key),
  ];

  late List<IntegrationData> _currentDisplayList;
  late List<IntegrationData> _poolList;
  bool _showAll = false;
  Timer? _cycleTimer;
  int _lastWipedIndex = -1;
  final Random _random = Random();
  
  // Track decryption triggers
  final List<bool> _tileTriggers = List.filled(20, false);

  @override
  void initState() {
    super.initState();
    // Initialize current display with first 8 items
    _currentDisplayList = List.from(_allIntegrations.take(8));
    // Pool lists consists of items 8 to 20
    _poolList = List.from(_allIntegrations.skip(8));
    
    _startAutoCycle();
  }

  @override
  void dispose() {
    _cycleTimer?.cancel();
    super.dispose();
  }

  void _startAutoCycle() {
    _cycleTimer?.cancel();
    _cycleTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_showAll || !mounted) return;
      _wipeAndCycleRandomCard();
    });
  }

  void _wipeAndCycleRandomCard() {
    setState(() {
      // Choose a random index out of the 8 visible tiles
      int indexToWipe = _random.nextInt(8);
      // Avoid wiping the exact same index consecutively if possible
      if (indexToWipe == _lastWipedIndex) {
        indexToWipe = (indexToWipe + 1) % 8;
      }
      _lastWipedIndex = indexToWipe;

      // Extract a random item from the pool list
      final int poolIndex = _random.nextInt(_poolList.length);
      final IntegrationData oldItem = _currentDisplayList[indexToWipe];
      final IntegrationData newItem = _poolList[poolIndex];

      // Swap the items
      _currentDisplayList[indexToWipe] = newItem;
      _poolList[poolIndex] = oldItem;
      
      // Trigger decrypt effect for this specific tile
      _tileTriggers[indexToWipe] = !_tileTriggers[indexToWipe];
    });
  }

  void _toggleShowAll() {
    setState(() {
      _showAll = !_showAll;
      if (_showAll) {
        _currentDisplayList = List.from(_allIntegrations);
        // Trigger decryption for all added cards
        for (int i = 0; i < _tileTriggers.length; i++) {
          _tileTriggers[i] = !_tileTriggers[i];
        }
      } else {
        _currentDisplayList = List.from(_allIntegrations.take(8));
        _poolList = List.from(_allIntegrations.skip(8));
      }
    });
  }

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
          const Text(
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
                _buildCoreExpertiseCard(isMobile: true),
                const SizedBox(height: 24),
                _buildStateManagementCard(),
                const SizedBox(height: 24),
                _buildPowerhouseIntegrationsCard(isMobile: true),
                const SizedBox(height: 24),
                _buildWebAndEcommerceCard(),
              ],
            )
          else
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildCoreExpertiseCard(isMobile: false),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 1,
                      child: _buildStateManagementCard(),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildPowerhouseIntegrationsCard(isMobile: false),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 1,
                      child: _buildWebAndEcommerceCard(),
                    ),
                  ],
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
          color: ThemeConfig.primary.withOpacity(0.3),
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
                  color: ThemeConfig.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ThemeConfig.primary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: const Text(
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
              const Text(
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
          style: const TextStyle(
            color: ThemeConfig.primary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: "JetBrains Mono",
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
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
          color: ThemeConfig.outlineVariant.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
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
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeConfig.outlineVariant.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
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
                  if (!_showAll) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: ThemeConfig.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: ThemeConfig.primary.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.sync_alt, color: ThemeConfig.primary, size: 10),
                          const SizedBox(width: 4),
                          Text(
                            "AUTO CYCLING",
                            style: TextStyle(
                              color: ThemeConfig.primary.withOpacity(0.8),
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
                      onTap: _toggleShowAll,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: ThemeConfig.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: ThemeConfig.primary.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _showAll ? Icons.terminal : Icons.lock_open,
                              color: ThemeConfig.primary,
                              size: 10,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _showAll ? "COMPACT" : "DECRYPT ALL",
                              style: const TextStyle(
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
            itemCount: _currentDisplayList.length,
            itemBuilder: (context, index) {
              final item = _currentDisplayList[index];
              return _IntegrationTile(
                key: ValueKey<int>(index),
                icon: item.icon,
                label: item.title,
                triggerDecrypt: _tileTriggers[index],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWebAndEcommerceCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeConfig.outlineVariant.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
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
                  style: const TextStyle(
                    color: ThemeConfig.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
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
    return const SectionHeader(
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
          color: ThemeConfig.outlineVariant.withOpacity(0.5),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
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
              : ThemeConfig.outlineVariant.withOpacity(0.2),
          width: _isDecrypting ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _displayedIcon,
            color: _isDecrypting ? ThemeConfig.primary : ThemeConfig.primary.withOpacity(0.9),
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
