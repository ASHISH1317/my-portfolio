import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../data/portfolio_data.dart';
import '../utils/resume_pdf_generator.dart';

class ResumePreviewDialog extends StatefulWidget {
  const ResumePreviewDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ResumePreviewDialog(),
    );
  }

  @override
  State<ResumePreviewDialog> createState() => _ResumePreviewDialogState();
}

class _ResumePreviewDialogState extends State<ResumePreviewDialog> {
  bool _isDownloading = false;

  Future<void> _handleDownload() async {
    setState(() => _isDownloading = true);
    try {
      await ResumePdfGenerator.downloadPdf();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to download PDF: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 768;

    return Obx(() {
      final themeColors = Get.find<ThemeController>().currentColors;
      final dialogBg = themeColors.background;
      final headerBg = themeColors.surfaceContainerHigh;
      final paperColor = themeColors.surfaceContainerLowest;
      final textColor = themeColors.textPrimary;
      final mutedTextColor = themeColors.textSecondary;
      final accentColor = themeColors.primary;
      final cardBorderColor = themeColors.outlineVariant;
      final circleBadgeBg = accentColor.withValues(alpha: 0.18);

      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 32,
          vertical: isMobile ? 16 : 24,
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 920, maxHeight: 940),
          decoration: BoxDecoration(
            color: dialogBg,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
            border: Border.all(color: cardBorderColor),
          ),
          child: Column(
            children: [
              // DIALOG TOP BAR
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: headerBg,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  border: Border(bottom: BorderSide(color: cardBorderColor)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.description_rounded, color: accentColor, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Resume Preview',
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _isDownloading ? null : _handleDownload,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        foregroundColor: themeColors.onPrimary,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 12 : 18,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      icon: _isDownloading
                          ? SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(themeColors.onPrimary),
                              ),
                            )
                          : const FaIcon(FontAwesomeIcons.download, size: 14),
                      label: Text(
                        _isDownloading ? 'Generating...' : 'Download PDF',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close_rounded, color: mutedTextColor),
                      tooltip: 'Close Preview',
                    ),
                  ],
                ),
              ),

              // RESUME CANVAS MATCHING TEMPLATE
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(isMobile ? 12 : 24),
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 840),
                      padding: EdgeInsets.all(isMobile ? 16 : 32),
                      decoration: BoxDecoration(
                        color: paperColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: cardBorderColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // TOP ACCENT LINE
                          Container(height: 1, color: cardBorderColor),
                          const SizedBox(height: 20),

                          // CENTERED HEADER
                          Text(
                            PortfolioData.fullName.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isMobile ? 22 : 28,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                              letterSpacing: 4.0,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            PortfolioData.title.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: accentColor,
                              letterSpacing: 3.0,
                            ),
                          ),

                          const SizedBox(height: 20),
                          Container(height: 1, color: cardBorderColor),
                          const SizedBox(height: 20),

                          // TWO-COLUMN BODY WITH VERTICAL SEPARATOR LINE
                          isMobile
                              ? Column(
                                  children: [
                                    _buildLeftColumn(accentColor, textColor, mutedTextColor, cardBorderColor, circleBadgeBg),
                                    const SizedBox(height: 24),
                                    Container(height: 1, color: cardBorderColor),
                                    const SizedBox(height: 24),
                                    _buildRightColumn(accentColor, textColor, mutedTextColor, cardBorderColor, circleBadgeBg),
                                  ],
                                )
                              : IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // LEFT COLUMN
                                      Expanded(
                                        flex: 35,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 20),
                                          child: _buildLeftColumn(accentColor, textColor, mutedTextColor, cardBorderColor, circleBadgeBg),
                                        ),
                                      ),

                                      // VERTICAL DIVIDER LINE
                                      VerticalDivider(
                                        width: 1,
                                        thickness: 1,
                                        color: cardBorderColor,
                                      ),

                                      // RIGHT COLUMN
                                      Expanded(
                                        flex: 65,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20),
                                          child: _buildRightColumn(accentColor, textColor, mutedTextColor, cardBorderColor, circleBadgeBg),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                          const SizedBox(height: 20),
                          Container(height: 1, color: cardBorderColor),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildLeftColumn(Color accentColor, Color textColor, Color mutedTextColor, Color cardBorderColor, Color circleBadgeBg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CONTACT
        _buildCircleSectionHeader('C', 'ONTACT', accentColor, textColor, circleBadgeBg),
        const SizedBox(height: 12),
        _buildContactRow(PortfolioData.phone, mutedTextColor),
        const SizedBox(height: 6),
        _buildContactRow(PortfolioData.email, mutedTextColor),
        const SizedBox(height: 6),
        _buildContactRow(PortfolioData.location, mutedTextColor),
        const SizedBox(height: 6),
        _buildContactRow('github.com/ASHISH1317', mutedTextColor),

        const SizedBox(height: 20),
        Divider(color: cardBorderColor, thickness: 1),
        const SizedBox(height: 16),

        // EDUCATION
        _buildCircleSectionHeader('E', 'DUCATION', accentColor, textColor, circleBadgeBg),
        const SizedBox(height: 12),
        ...PortfolioData.education.map((edu) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  edu.period,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: accentColor),
                ),
                const SizedBox(height: 2),
                Text(
                  edu.institution.toUpperCase(),
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textColor),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: accentColor, fontWeight: FontWeight.bold, fontSize: 13)),
                    Expanded(
                      child: Text(
                        '${edu.degree} (${edu.grade})',
                        style: TextStyle(fontSize: 12.5, color: mutedTextColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: 12),
        Divider(color: cardBorderColor, thickness: 1),
        const SizedBox(height: 16),

        // SKILLS
        _buildCircleSectionHeader('S', 'KILLS', accentColor, textColor, circleBadgeBg),
        const SizedBox(height: 12),
        ...PortfolioData.skills.expand((cat) => cat.skills).map((skill) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Text('• ', style: TextStyle(color: accentColor, fontWeight: FontWeight.bold, fontSize: 13)),
                Text(
                  skill.name,
                  style: TextStyle(fontSize: 12.5, color: mutedTextColor),
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: 12),
        Divider(color: cardBorderColor, thickness: 1),
        const SizedBox(height: 16),

        // OPEN SOURCE PACKAGES
        _buildCircleSectionHeader('P', 'ACKAGES', accentColor, textColor, circleBadgeBg),
        const SizedBox(height: 12),
        ...PortfolioData.packages.take(3).map((pkg) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Text('• ', style: TextStyle(color: accentColor, fontWeight: FontWeight.bold, fontSize: 13)),
                Text(
                  pkg.title,
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: mutedTextColor),
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: 12),
        Divider(color: cardBorderColor, thickness: 1),
        const SizedBox(height: 16),

        // ADDITIONAL TECH
        _buildCircleSectionHeader('T', 'ECHNOLOGIES', accentColor, textColor, circleBadgeBg),
        const SizedBox(height: 12),
        ...[
          "Git & GitHub Version Control",
          "GitHub Actions (CI/CD)",
          "GraphQL & REST APIs",
          "SQLite / Hive / PostgreSQL",
          "Docker Containers",
          "HTML5, CSS3 & TypeScript",
          "Agile & Scrum Practices",
          "Jira & Slack Collaboration",
        ].map((tech) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Text('• ', style: TextStyle(color: accentColor, fontWeight: FontWeight.bold, fontSize: 13)),
                Text(
                  tech,
                  style: TextStyle(fontSize: 12.5, color: mutedTextColor),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildRightColumn(Color accentColor, Color textColor, Color mutedTextColor, Color cardBorderColor, Color circleBadgeBg) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // PROFILE SUMMARY
        _buildCircleSectionHeader('P', 'ROFILE SUMMARY', accentColor, textColor, circleBadgeBg),
        const SizedBox(height: 12),
        Text(
          '${PortfolioData.aboutText1} ${PortfolioData.aboutText2}',
          style: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: mutedTextColor,
          ),
        ),

        const SizedBox(height: 20),
        Divider(color: cardBorderColor, thickness: 1),
        const SizedBox(height: 16),

        // WORK EXPERIENCE
        _buildCircleSectionHeader('W', 'ORK EXPERIENCE', accentColor, textColor, circleBadgeBg),
        const SizedBox(height: 12),
        ...PortfolioData.experiences.map((exp) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      exp.company,
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      exp.period.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: mutedTextColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  exp.role,
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: accentColor,
                  ),
                ),
                const SizedBox(height: 6),
                ...exp.bullets.map((bullet) => Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: TextStyle(color: accentColor, fontWeight: FontWeight.bold, fontSize: 13)),
                      Expanded(
                        child: Text(
                          bullet,
                          style: TextStyle(fontSize: 12.5, height: 1.45, color: mutedTextColor),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          );
        }),

        const SizedBox(height: 12),
        Divider(color: cardBorderColor, thickness: 1),
        const SizedBox(height: 16),

        // FEATURED PROJECTS
        _buildCircleSectionHeader('F', 'EATURED PROJECTS', accentColor, textColor, circleBadgeBg),
        const SizedBox(height: 12),
        if (isMobile)
          ...PortfolioData.projects
              .takeWhile((proj) => proj.title.toLowerCase() != 'slay')
              .map((proj) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _buildDialogProjectItem(proj, accentColor, textColor, mutedTextColor),
                  ))
        else
          ...(() {
            final previewProjects = PortfolioData.projects
                .takeWhile((proj) => proj.title.toLowerCase() != 'slay')
                .toList();
            return List.generate((previewProjects.length / 2).ceil(), (index) {
              final proj1 = previewProjects[index * 2];
              final proj2 = (index * 2 + 1 < previewProjects.length) ? previewProjects[index * 2 + 1] : null;
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildDialogProjectItem(proj1, accentColor, textColor, mutedTextColor),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: proj2 != null
                          ? _buildDialogProjectItem(proj2, accentColor, textColor, mutedTextColor)
                          : const SizedBox(),
                    ),
                  ],
                ),
              );
            });
          })(),
      ],
    );
  }

  Widget _buildDialogProjectItem(ProjectData proj, Color accentColor, Color textColor, Color mutedTextColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                proj.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              proj.platformText,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          proj.description,
          style: TextStyle(fontSize: 12, height: 1.35, color: mutedTextColor),
        ),
        const SizedBox(height: 4),
        Text(
          'Tech Stack: ${proj.techStack.map((t) => t.name).join(", ")}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            color: accentColor.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow(String text, Color textColor) {
    return Text(
      text,
      style: TextStyle(fontSize: 12.5, color: textColor),
    );
  }

  Widget _buildCircleSectionHeader(String firstChar, String restText, Color accentColor, Color textColor, Color circleBg) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: circleBg,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              firstChar,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          restText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: textColor,
            letterSpacing: 2.0,
          ),
        ),
      ],
    );
  }
}
