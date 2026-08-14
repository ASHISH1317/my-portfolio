import 'package:flutter/foundation.dart';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import '../widgets/scroll_reveal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/custom_card.dart';
import '../widgets/cool_dialog.dart';
import '../widgets/section_header.dart';
import '../controllers/contact_controller.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  ContactController get controller => Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 900;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 50),
          isMobile
              ? Column(
                  children: [
                    ScrollReveal(
                      direction: RevealDirection.up,
                      delay: Duration.zero,
                      child: _buildContactInfo(isMobile: true),
                    ),
                    const SizedBox(height: 48),
                    ScrollReveal(
                      direction: RevealDirection.up,
                      delay: const Duration(milliseconds: 150),
                      child: _buildFormCard(isMobile: true),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: ScrollReveal(
                        direction: RevealDirection.left,
                        delay: Duration.zero,
                        child: _buildContactInfo(isMobile: false),
                      ),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      flex: 6,
                      child: ScrollReveal(
                        direction: RevealDirection.right,
                        delay: const Duration(milliseconds: 100),
                        child: _buildFormCard(isMobile: false),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SectionHeader(
      title: "Let's build something great",
      subtitle: "Get In Touch",
      index: "07",
    );
  }

  Widget _buildContactInfo({required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's build something great",
          style: ThemeConfig.h3.copyWith(
            fontSize: 22,
            height: 1.4,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 16),
        Text(
          "Have a project in mind or want to discuss an opportunity? I'd love to hear from you. Drop me a message and I'll get back to you as soon as possible.",
          style: ThemeConfig.body,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 40),
        _buildInfoRow(
          Icons.mail_outlined,
          "EMAIL",
          controller.email,
          onTap: () => _showContactConfirm(
            "Send Email",
            "Do you want to send an email to ${controller.email}?",
            controller.emailUrl,
          ),
        ),
        const SizedBox(height: 24),
        _buildInfoRow(
          Icons.phone_android_outlined,
          "PHONE",
          controller.phone,
          onTap: () => _showContactConfirm(
            "Call Number",
            "Do you want to call ${controller.phone}?",
            "tel:${controller.phone.replaceAll(' ', '')}",
          ),
        ),
        const SizedBox(height: 24),
        _buildInfoRow(
          Icons.location_on_outlined,
          "LOCATION",
          controller.location,
          onTap: () => _showContactConfirm(
            "Open Location",
            "Do you want to view Surat, Gujarat, India on Google Maps?",
            "https://www.google.com/maps/search/?api=1&query=Surat,+Gujarat,+India",
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildSocialIcon(FontAwesomeIcons.github, PortfolioData.github1),
            const SizedBox(width: 16),
            _buildSocialIcon(FontAwesomeIcons.github, PortfolioData.github2),
            const SizedBox(width: 16),
            _buildSocialIcon(FontAwesomeIcons.linkedin, PortfolioData.linkedin),
            const SizedBox(width: 16),
            _buildSocialIcon(FontAwesomeIcons.instagram, PortfolioData.instagram),
            const SizedBox(width: 16),
            _buildSocialIcon(FontAwesomeIcons.whatsapp, PortfolioData.whatsapp),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {VoidCallback? onTap}) {
    final Widget widget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ThemeConfig.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Icon(icon, color: ThemeConfig.primary, size: 24),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: ThemeConfig.caption.copyWith(letterSpacing: 1.5, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(value, style: ThemeConfig.bodyBold.copyWith(fontSize: 15)),
          ],
        ),
      ],
    );

    if (onTap != null) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: widget,
        ),
      );
    }
    return widget;
  }

  Widget _buildSocialIcon(dynamic icon, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (kIsWeb) {
            html.window.open(url, '_blank');
          } else {
            final Uri uri = Uri.parse(url);
            if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
              debugPrint("Could not launch $url");
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: ThemeConfig.outlineVariant.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: ThemeConfig.outlineVariant),
          ),
          child: FaIcon(icon, color: ThemeConfig.textSecondary, size: 20),
        ),
      ),
    );
  }

  Widget _buildFormCard({required bool isMobile}) {
    return CustomCard(
      padding: isMobile
          ? const EdgeInsets.symmetric(horizontal: 20, vertical: 24)
          : const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: ThemeConfig.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "Send Message",
                  style: ThemeConfig.h3.copyWith(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: controller.nameController,
              label: "YOUR NAME",
              validator: (val) => val == null || val.isEmpty ? "Please enter your name" : null,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: controller.emailController,
              label: "EMAIL ADDRESS",
              keyboardType: TextInputType.emailAddress,
              validator: (val) => val == null || !val.contains("@") ? "Please enter a valid email" : null,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: controller.subjectController,
              label: "SUBJECT",
              validator: (val) => val == null || val.isEmpty ? "Please enter a subject" : null,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: controller.messageController,
              label: "MESSAGE",
              maxLines: 4,
              validator: (val) => val == null || val.isEmpty ? "Please write your message" : null,
            ),
            const SizedBox(height: 32),
            isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SubmitButton(
                        onTap: () => controller.submitViaWhatsApp(context),
                        baseColor: const Color(0xFF25D366),
                        icon: FontAwesomeIcons.whatsapp,
                        text: "Send via WhatsApp",
                        isFullWidth: true,
                      ),
                      const SizedBox(height: 16),
                      _SubmitButton(
                        onTap: () => controller.submitViaEmail(context),
                        baseColor: ThemeConfig.primary,
                        icon: Icons.mail_outline_rounded,
                        text: "Send via Email",
                        isFullWidth: true,
                        isPrimaryTextDark: true,
                      ),
                    ],
                  )
                : Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _SubmitButton(
                        onTap: () => controller.submitViaWhatsApp(context),
                        baseColor: const Color(0xFF25D366),
                        icon: FontAwesomeIcons.whatsapp,
                        text: "Send via WhatsApp",
                        isFullWidth: false,
                      ),
                      _SubmitButton(
                        onTap: () => controller.submitViaEmail(context),
                        baseColor: ThemeConfig.primary,
                        icon: Icons.mail_outline_rounded,
                        text: "Send via Email",
                        isFullWidth: false,
                        isPrimaryTextDark: true,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(color: ThemeConfig.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: ThemeConfig.textSecondary.withValues(alpha: 0.7),
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
        floatingLabelStyle: TextStyle(color: ThemeConfig.primary),
        fillColor: ThemeConfig.surfaceContainerLow.withValues(alpha: 0.4),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ThemeConfig.outline.withValues(alpha: 0.12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ThemeConfig.outline.withValues(alpha: 0.12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ThemeConfig.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
    );
  }

  void _showContactConfirm(String title, String message, String actionUrl) {
    showCoolDialog(
      context: context,
      title: title,
      message: message,
      icon: Icons.open_in_new_rounded,
      accentColor: ThemeConfig.primary,
      primaryButtonText: "Yes",
      onPrimaryPressed: () {
        Navigator.of(context).pop();
        controller.launchURL(actionUrl);
      },
      secondaryButtonText: "Cancel",
      onSecondaryPressed: () => Navigator.of(context).pop(),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  final VoidCallback onTap;
  final Color baseColor;
  final dynamic icon;
  final String text;
  final bool isFullWidth;
  final bool isPrimaryTextDark;

  const _SubmitButton({
    required this.onTap,
    required this.baseColor,
    required this.icon,
    required this.text,
    required this.isFullWidth,
    this.isPrimaryTextDark = false,
  });

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color contentColor = _isHovered
        ? (widget.isPrimaryTextDark ? Colors.black : Colors.white)
        : widget.baseColor;

    final Color bgColor = _isHovered
        ? widget.baseColor
        : widget.baseColor.withValues(alpha: 0.05);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? 1.025 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isHovered ? widget.baseColor : widget.baseColor.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: widget.baseColor.withValues(alpha: 0.25),
                        blurRadius: 16,
                        spreadRadius: 1,
                        offset: const Offset(0, 6),
                      )
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: widget.isFullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon is IconData
                    ? Icon(widget.icon, color: contentColor, size: 20)
                    : FaIcon(widget.icon, color: contentColor, size: 20),
                const SizedBox(width: 10),
                Text(
                  widget.text,
                  style: TextStyle(
                    color: contentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
