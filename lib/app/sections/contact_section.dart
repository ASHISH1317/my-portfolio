import 'package:flutter/foundation.dart';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/custom_card.dart';
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
                    _buildContactInfo(isMobile: true),
                    const SizedBox(height: 48),
                    _buildFormCard(isMobile: true),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: _buildContactInfo(isMobile: false),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      flex: 6,
                      child: _buildFormCard(isMobile: false),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const SectionHeader(
      title: "Let's build something great",
      subtitle: "Get In Touch",
      index: "06",
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
            border: Border.all(color: Colors.white.withOpacity(0.05)),
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
            color: Colors.white.withOpacity(0.02),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: FaIcon(icon, color: Colors.white70, size: 20),
        ),
      ),
    );
  }

  Widget _buildFormCard({required bool isMobile}) {
    return CustomCard(
      glowColor: const Color(0xFF25D366),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Send Message",
                style: ThemeConfig.h3.copyWith(fontSize: 20),
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
                        _buildSubmitButton(
                          onTap: () => controller.submitViaWhatsApp(context),
                          color: const Color(0xFF25D366),
                          icon: FontAwesomeIcons.whatsapp,
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          text: "Send via WhatsApp",
                          isFullWidth: true,
                        ),
                        const SizedBox(height: 16),
                        _buildSubmitButton(
                          onTap: () => controller.submitViaEmail(context),
                          color: ThemeConfig.primary,
                          icon: Icons.mail_outline_rounded,
                          iconColor: Colors.black,
                          textColor: Colors.black,
                          text: "Send via Email",
                          isFullWidth: true,
                        ),
                      ],
                    )
                  : Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _buildSubmitButton(
                          onTap: () => controller.submitViaWhatsApp(context),
                          color: const Color(0xFF25D366),
                          icon: FontAwesomeIcons.whatsapp,
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          text: "Send via WhatsApp",
                          isFullWidth: false,
                        ),
                        _buildSubmitButton(
                          onTap: () => controller.submitViaEmail(context),
                          color: ThemeConfig.primary,
                          icon: Icons.mail_outline_rounded,
                          iconColor: Colors.black,
                          textColor: Colors.black,
                          text: "Send via Email",
                          isFullWidth: false,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton({
    required VoidCallback onTap,
    required Color color,
    required dynamic icon,
    required Color iconColor,
    required Color textColor,
    required String text,
    required bool isFullWidth,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 16,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Row(
            mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon is IconData
                  ? Icon(icon, color: iconColor, size: 20)
                  : FaIcon(icon, color: iconColor, size: 20),
              const SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
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
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: ThemeConfig.textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
        floatingLabelStyle: const TextStyle(color: ThemeConfig.primary),
        fillColor: Colors.black26,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ThemeConfig.primary, width: 1.5),
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ThemeConfig.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: ThemeConfig.primary, width: 1.5),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          message,
          style: const TextStyle(color: ThemeConfig.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "Cancel",
              style: TextStyle(color: ThemeConfig.textMuted),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              controller.launchURL(actionUrl);
            },
            child: const Text(
              "Yes",
              style: TextStyle(color: ThemeConfig.primary, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
