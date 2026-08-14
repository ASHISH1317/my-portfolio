import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/theme_config.dart';

class PackageCodeDialog extends StatelessWidget {
  final Map<String, String> package;

  const PackageCodeDialog({
    super.key,
    required this.package,
  });

  @override
  Widget build(BuildContext context) {
    final String name = package["name"] ?? "Package";
    final String desc = package["description"] ?? "";
    final String version = package["version"] ?? "v1.0.0";
    final String pubUrl = package["pubUrl"] ?? "https://pub.dev";
    final String sampleCode = package["sampleCode"] ?? '''
import 'package:$name/$name.dart';

void main() {
  // Initialize $name
  final instance = ${name.split('_').map((w) => w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1)).join('')}();
  instance.initialize();
}
''';

    final String pubCommand = "flutter pub add $name";

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Obx(() {
        return Container(
          constraints: const BoxConstraints(maxWidth: 680),
          decoration: BoxDecoration(
            color: ThemeConfig.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: ThemeConfig.primary.withValues(alpha: 0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: ThemeConfig.primary.withValues(alpha: 0.15),
                blurRadius: 30,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: ThemeConfig.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: FaIcon(FontAwesomeIcons.cubes, color: ThemeConfig.primary, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  color: ThemeConfig.textPrimary,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: ThemeConfig.primary.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  version,
                                  style: TextStyle(
                                    color: ThemeConfig.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            desc,
                            style: TextStyle(
                              color: ThemeConfig.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close_rounded, color: ThemeConfig.textMuted),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Code Playground content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Installation snippet
                      Text(
                        "INSTALLATION",
                        style: TextStyle(
                          color: ThemeConfig.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildCodeBox(context, pubCommand),

                      const SizedBox(height: 20),

                      // Code snippet
                      Text(
                        "EXAMPLE USAGE",
                        style: TextStyle(
                          color: ThemeConfig.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildCodeBox(context, sampleCode),
                    ],
                  ),
                ),
              ),

              // Actions Footer
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        final uri = Uri.parse(pubUrl);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      },
                      icon: const FaIcon(FontAwesomeIcons.arrowUpRightFromSquare, size: 14),
                      label: const Text("View on Pub.dev"),
                      style: TextButton.styleFrom(
                        foregroundColor: ThemeConfig.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCodeBox(BuildContext context, String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ThemeConfig.outline, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SelectableText(
              code.trim(),
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: ThemeConfig.textPrimary,
                height: 1.5,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.copy_rounded, color: ThemeConfig.primary, size: 18),
            tooltip: "Copy Code",
            onPressed: () {
              Clipboard.setData(ClipboardData(text: code.trim()));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: ThemeConfig.surfaceContainerHigh,
                  content: Text(
                    "Copied to clipboard!",
                    style: TextStyle(color: ThemeConfig.primary),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
