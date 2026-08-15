import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import '../data/theme_config.dart';
import '../widgets/custom_card.dart';

class FlutterStoryDialog extends StatelessWidget {
  const FlutterStoryDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (context) => const FlutterStoryDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 768;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800, maxHeight: 700),
          child: CustomCard(
            enableHover: true,
            borderRadius: 24.0,
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: ThemeConfig.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            "😂",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "My Flutter Journey",
                          style: TextStyle(
                            fontSize: isMobile ? 18 : 20,
                            fontWeight: FontWeight.bold,
                            color: ThemeConfig.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close_rounded, color: ThemeConfig.textPrimary),
                      splashRadius: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Premium gradient divider
                Container(
                  height: 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ThemeConfig.primary,
                        ThemeConfig.primary.withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Story Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How I Accidentally Became a Flutter Developer 😂",
                          style: ThemeConfig.h3.copyWith(
                            fontSize: isMobile ? 20 : 22,
                            fontWeight: FontWeight.w800,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildParagraph("After college, I had absolutely no idea what to do next."),
                        _buildParagraph("Like every aspiring software engineer, I started with **HTML, CSS, and Python**. Because apparently, that's the official, universal tutorial for entering the tech world. 😂"),
                        _buildParagraph("But then I thought, *“Let’s try something new.”*"),
                        _buildParagraph("And that’s when **Flutter** entered the chat. 🚀"),
                        _buildParagraph("At the time, Flutter was everywhere. Everyone was talking about it, so I thought, *“Why not?”*"),
                        _buildParagraph("Bought a couple of Udemy courses, learned the basics, and started building tiny apps."),
                        _buildParagraph("One of my biggest achievements back then?"),
                        _buildParagraph("**I'M RICH 🤣**"),
                        _buildParagraph("Yes, that famous beginner Flutter app. We all have to start somewhere!"),
                        _buildParagraph("Then came the dreaded internship hunt."),
                        _buildParagraph("I applied everywhere, only to hear the classic catch-22:"),
                        _buildParagraph("> “We need someone with experience.”"),
                        _buildParagraph("**Experience… for an internship.** 🤡"),
                        _buildParagraph("After a LOT of applications and rejection emails, I finally landed my first internship opportunity."),
                        _buildParagraph("And somehow, that first breakthrough became the beginning of everything."),
                        _buildParagraph("Fast-forward a few years…"),
                        _buildParagraph("Here I am — **apparently a Senior Flutter Developer.** 😎"),
                        _buildParagraph("From **“I'M RICH”** to **“I’m responsible for this production codebase.”**"),
                        _buildParagraph("What a journey. 😂🚀"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Bottom close button (centered & content-fit)
                Center(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ThemeConfig.primary,
                      side: BorderSide(
                        color: ThemeConfig.primary.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Cool Story, Bro! 👍",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParagraph(String para) {
    if (para.startsWith('>')) {
      final cleanText = para.replaceFirst('>', '').trim().replaceAll('“', '"').replaceAll('”', '"');
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: ThemeConfig.primary.withValues(alpha: 0.05),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          border: Border(
            left: BorderSide(
              color: ThemeConfig.primary,
              width: 4,
            ),
          ),
        ),
        child: Text(
          cleanText,
          style: ThemeConfig.body.copyWith(
            fontStyle: FontStyle.italic,
            color: ThemeConfig.textPrimary,
            fontSize: 15,
          ),
        ),
      );
    }

    final List<TextSpan> spans = [];
    final boldRegex = RegExp(r'\*\*(.*?)\*\*|\*(.*?)\*');
    int lastMatchEnd = 0;

    for (final match in boldRegex.allMatches(para)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: para.substring(lastMatchEnd, match.start),
          style: ThemeConfig.body.copyWith(color: ThemeConfig.textSecondary),
        ));
      }
      
      if (match.group(1) != null) {
        spans.add(TextSpan(
          text: match.group(1),
          style: ThemeConfig.bodyBold.copyWith(color: ThemeConfig.textPrimary),
        ));
      } else if (match.group(2) != null) {
        spans.add(TextSpan(
          text: match.group(2),
          style: ThemeConfig.body.copyWith(
            fontStyle: FontStyle.italic,
            color: ThemeConfig.textPrimary,
          ),
        ));
      }
      
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < para.length) {
      spans.add(TextSpan(
        text: para.substring(lastMatchEnd),
        style: ThemeConfig.body.copyWith(color: ThemeConfig.textSecondary),
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: RichText(
        text: TextSpan(children: spans),
      ),
    );
  }
}
