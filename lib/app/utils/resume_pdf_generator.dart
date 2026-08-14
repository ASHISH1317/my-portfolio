import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Color;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:html' as html;
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../data/portfolio_data.dart';

class ResumePdfGenerator {
  static PdfColor _toPdfColor(Color c) {
    return PdfColor(c.r, c.g, c.b, c.a);
  }

  static Future<Uint8List> generatePdf() async {
    final themeColors = Get.find<ThemeController>().currentColors;

    final primaryColor = _toPdfColor(themeColors.primary);
    final bgDark = _toPdfColor(themeColors.surfaceContainerLowest);
    final textPrimary = _toPdfColor(themeColors.textPrimary);
    final textSecondary = _toPdfColor(themeColors.textSecondary);
    final textMuted = _toPdfColor(themeColors.textMuted);
    final dividerColor = _toPdfColor(themeColors.outlineVariant);

    final fontRegular = await PdfGoogleFonts.interRegular();
    final fontBold = await PdfGoogleFonts.interBold();
    final fontSemiBold = await PdfGoogleFonts.interSemiBold();
    final fontItalic = await PdfGoogleFonts.interItalic();

    final pdf = pw.Document(
      title: '${PortfolioData.fullName} - Resume',
      author: PortfolioData.fullName,
      subject: PortfolioData.title,
    );

    final pageTheme = pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      buildBackground: (pw.Context context) {
        return pw.FullPage(
          ignoreMargins: true,
          child: pw.Container(color: bgDark),
        );
      },
      theme: pw.ThemeData.withFont(
        base: fontRegular,
        bold: fontBold,
        italic: fontItalic,
      ),
    );

    pdf.addPage(
      pw.Page(
        pageTheme: pageTheme,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              // TOP BORDER LINE
              pw.Container(height: 1, color: dividerColor),
              pw.SizedBox(height: 14),

              // NAME HEADER (CENTERED & SPACED)
              pw.Text(
                PortfolioData.fullName.toUpperCase(),
                style: pw.TextStyle(
                  font: fontBold,
                  fontSize: 24,
                  color: textPrimary,
                  letterSpacing: 4.0,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                PortfolioData.title.toUpperCase(),
                style: pw.TextStyle(
                  font: fontSemiBold,
                  fontSize: 10,
                  color: primaryColor,
                  letterSpacing: 3.0,
                ),
              ),

              pw.SizedBox(height: 14),
              pw.Container(height: 1, color: dividerColor),
              pw.SizedBox(height: 14),

              // MAIN TWO-COLUMN BODY WITH VERTICAL SEPARATOR LINE
              pw.Expanded(
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // ===== LEFT COLUMN (CONTACT, EDUCATION, SKILLS, PACKAGES) =====
                    pw.Expanded(
                      flex: 35,
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(right: 14),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            // CONTACT
                            _buildCircleSectionHeader('CONTACT', primaryColor, textPrimary, fontBold),
                            pw.SizedBox(height: 8),
                            _buildContactRow(PortfolioData.phone, textSecondary, fontRegular),
                            pw.SizedBox(height: 4),
                            _buildContactRow(PortfolioData.email, textSecondary, fontRegular),
                            pw.SizedBox(height: 4),
                            _buildContactRow(PortfolioData.location, textSecondary, fontRegular),
                            pw.SizedBox(height: 4),
                            _buildContactRow('github.com/ASHISH1317', textSecondary, fontRegular),

                            pw.SizedBox(height: 12),
                            pw.Container(height: 0.8, color: dividerColor),
                            pw.SizedBox(height: 12),

                            // EDUCATION
                            _buildCircleSectionHeader('EDUCATION', primaryColor, textPrimary, fontBold),
                            pw.SizedBox(height: 8),
                            ...PortfolioData.education.map((edu) {
                              return pw.Container(
                                margin: const pw.EdgeInsets.only(bottom: 8),
                                child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      edu.period,
                                      style: pw.TextStyle(font: fontSemiBold, fontSize: 7.5, color: primaryColor),
                                    ),
                                    pw.SizedBox(height: 1),
                                    pw.Text(
                                      edu.institution.toUpperCase(),
                                      style: pw.TextStyle(font: fontBold, fontSize: 8, color: textPrimary),
                                    ),
                                    pw.SizedBox(height: 2),
                                    pw.Row(
                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text('• ', style: pw.TextStyle(font: fontBold, fontSize: 8, color: primaryColor)),
                                        pw.Expanded(
                                          child: pw.Text(
                                            '${edu.degree} (${edu.grade})',
                                            style: pw.TextStyle(font: fontRegular, fontSize: 7.5, color: textSecondary),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),

                            pw.SizedBox(height: 8),
                            pw.Container(height: 0.8, color: dividerColor),
                            pw.SizedBox(height: 10),

                            // SKILLS
                            _buildCircleSectionHeader('SKILLS', primaryColor, textPrimary, fontBold),
                            pw.SizedBox(height: 8),
                            ...PortfolioData.skills.expand((cat) => cat.skills).map((skill) {
                              return pw.Padding(
                                padding: const pw.EdgeInsets.only(bottom: 2.5),
                                child: pw.Row(
                                  children: [
                                    pw.Text('• ', style: pw.TextStyle(font: fontBold, fontSize: 8, color: primaryColor)),
                                    pw.Text(
                                      skill.name,
                                      style: pw.TextStyle(font: fontRegular, fontSize: 7.8, color: textSecondary),
                                    ),
                                  ],
                                ),
                              );
                            }),

                            pw.SizedBox(height: 8),
                            pw.Container(height: 0.8, color: dividerColor),
                            pw.SizedBox(height: 10),

                            // OPEN SOURCE PACKAGES
                            _buildCircleSectionHeader('PACKAGES', primaryColor, textPrimary, fontBold),
                            pw.SizedBox(height: 6),
                            ...PortfolioData.packages.take(3).map((pkg) {
                              return pw.Padding(
                                padding: const pw.EdgeInsets.only(bottom: 3),
                                child: pw.Row(
                                  children: [
                                    pw.Text('• ', style: pw.TextStyle(font: fontBold, fontSize: 8, color: primaryColor)),
                                    pw.Text(
                                      pkg.title,
                                      style: pw.TextStyle(font: fontSemiBold, fontSize: 7.5, color: textSecondary),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),

                    // VERTICAL DIVIDER LINE EXACT TO TEMPLATE
                    pw.Container(
                      width: 1,
                      color: dividerColor,
                    ),

                    // ===== RIGHT COLUMN (PROFILE SUMMARY & WORK EXPERIENCE & PROJECTS) =====
                    pw.Expanded(
                      flex: 65,
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 14),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            // PROFILE SUMMARY
                            _buildCircleSectionHeader('PROFILE SUMMARY', primaryColor, textPrimary, fontBold),
                            pw.SizedBox(height: 8),
                            pw.Text(
                              '${PortfolioData.aboutText1} ${PortfolioData.aboutText2}',
                              style: pw.TextStyle(
                                font: fontRegular,
                                fontSize: 8,
                                color: textSecondary,
                                lineSpacing: 1.25,
                              ),
                            ),

                            pw.SizedBox(height: 10),
                            pw.Container(height: 0.8, color: dividerColor),
                            pw.SizedBox(height: 10),

                            // WORK EXPERIENCE
                            _buildCircleSectionHeader('WORK EXPERIENCE', primaryColor, textPrimary, fontBold),
                            pw.SizedBox(height: 8),

                            ...PortfolioData.experiences.map((exp) {
                              return pw.Container(
                                margin: const pw.EdgeInsets.only(bottom: 8),
                                child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Row(
                                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Text(
                                          exp.company,
                                          style: pw.TextStyle(font: fontBold, fontSize: 9, color: textPrimary),
                                        ),
                                        pw.Text(
                                          exp.period.toUpperCase(),
                                          style: pw.TextStyle(font: fontSemiBold, fontSize: 7.5, color: textMuted),
                                        ),
                                      ],
                                    ),
                                    pw.SizedBox(height: 1),
                                    pw.Text(
                                      exp.role,
                                      style: pw.TextStyle(font: fontItalic, fontSize: 8, color: primaryColor),
                                    ),
                                    pw.SizedBox(height: 4),
                                    ...exp.bullets.map((bullet) => pw.Padding(
                                      padding: const pw.EdgeInsets.only(left: 4, bottom: 2),
                                      child: pw.Row(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text('• ', style: pw.TextStyle(font: fontBold, fontSize: 8, color: primaryColor)),
                                          pw.Expanded(
                                            child: pw.Text(
                                              bullet,
                                              style: pw.TextStyle(font: fontRegular, fontSize: 7.6, color: textSecondary, lineSpacing: 1.15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              );
                            }),

                            pw.SizedBox(height: 6),
                            pw.Container(height: 0.8, color: dividerColor),
                            pw.SizedBox(height: 8),

                            // FEATURED PROJECTS
                            _buildCircleSectionHeader('FEATURED PROJECTS', primaryColor, textPrimary, fontBold),
                            pw.SizedBox(height: 8),

                            ...PortfolioData.projects.map((proj) {
                              return pw.Container(
                                margin: const pw.EdgeInsets.only(bottom: 6),
                                child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Row(
                                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Text(
                                          proj.title,
                                          style: pw.TextStyle(font: fontBold, fontSize: 8.5, color: textPrimary),
                                        ),
                                        pw.Text(
                                          'iOS & Android',
                                          style: pw.TextStyle(font: fontSemiBold, fontSize: 7, color: primaryColor),
                                        ),
                                      ],
                                    ),
                                    pw.SizedBox(height: 2),
                                    pw.Text(
                                      proj.description,
                                      style: pw.TextStyle(font: fontRegular, fontSize: 7.4, color: textSecondary, lineSpacing: 1.1),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 6),
              pw.Container(height: 1, color: dividerColor),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildContactRow(String text, PdfColor textColor, pw.Font fontRegular) {
    return pw.Text(
      text,
      style: pw.TextStyle(font: fontRegular, fontSize: 7.8, color: textColor),
    );
  }

  static pw.Widget _buildCircleSectionHeader(
    String title,
    PdfColor primaryColor,
    PdfColor textPrimary,
    pw.Font fontBold,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Container(
          width: 6,
          height: 6,
          decoration: pw.BoxDecoration(
            color: primaryColor,
            shape: pw.BoxShape.circle,
          ),
        ),
        pw.SizedBox(width: 6),
        pw.Text(
          title.toUpperCase(),
          style: pw.TextStyle(
            font: fontBold,
            fontSize: 9,
            color: textPrimary,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  static Future<void> downloadPdf() async {
    final pdfBytes = await generatePdf();
    final fileName = '${PortfolioData.fullName.replaceAll(' ', '_')}_Resume.pdf';

    if (kIsWeb) {
      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', fileName)
        ..style.display = 'none';
      html.document.body?.children.add(anchor);
      anchor.click();
      anchor.remove();
      html.Url.revokeObjectUrl(url);
    } else {
      await Printing.sharePdf(
        bytes: pdfBytes,
        filename: fileName,
      );
    }
  }
}
