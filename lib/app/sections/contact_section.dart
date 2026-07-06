import 'package:flutter/foundation.dart';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/theme_config.dart';
import '../data/portfolio_data.dart';
import '../widgets/custom_card.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitViaWhatsApp() {
    if (_formKey.currentState!.validate()) {
      final text = "Hello Ashish,\n\nName: ${_nameController.text}\nEmail: ${_emailController.text}\nSubject: ${_subjectController.text}\n\nMessage: ${_messageController.text}";
      final url = "https://wa.me/919913629852?text=${Uri.encodeComponent(text)}";
      
      if (kIsWeb) {
        html.window.open(url, '_blank');
      } else {
        launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
      
      _showSuccessDialog("WhatsApp Redirect", "Redirecting you to chat on WhatsApp...", const Color(0xFF25D366));
    }
  }

  void _submitViaEmail() {
    if (_formKey.currentState!.validate()) {
      final subject = "Portfolio Query: ${_subjectController.text}";
      final body = "Name: ${_nameController.text}\nEmail: ${_emailController.text}\n\nMessage:\n${_messageController.text}";
      final url = "mailto:${PortfolioData.email}?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}";
      
      if (kIsWeb) {
        html.window.open(url, '_blank');
      } else {
        launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
      
      _showSuccessDialog("Email Redirect", "Opening your default email app...", ThemeConfig.primary);
    }
  }

  void _showSuccessDialog(String title, String message, Color accentColor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ThemeConfig.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: accentColor, width: 1.5),
        ),
        title: Row(
          children: [
            Icon(Icons.check_circle_outline_rounded, color: accentColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(color: ThemeConfig.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _nameController.clear();
              _emailController.clear();
              _subjectController.clear();
              _messageController.clear();
            },
            child: Text(
              "OK",
              style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

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
                    _buildFormCard(),
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
                      child: _buildFormCard(),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's build something great",
          style: ThemeConfig.h2,
        ),
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: ThemeConfig.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo({required bool isMobile}) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "Let's build something great",
          style: ThemeConfig.h3.copyWith(
            fontSize: 22,
            height: 1.4,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 16),
        Text(
          "Have a project in mind or want to discuss an opportunity? I'd love to hear from you. Drop me a message and I'll get back to you as soon as possible.",
          style: ThemeConfig.body,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 40),
        _buildInfoRow(
          Icons.mail_outlined,
          "EMAIL",
          PortfolioData.email,
          onTap: () => _showContactConfirm(
            "Send Email",
            "Do you want to send an email to ${PortfolioData.email}?",
            PortfolioData.emailUrl,
          ),
        ),
        const SizedBox(height: 24),
        _buildInfoRow(
          Icons.phone_android_outlined,
          "PHONE",
          PortfolioData.phone,
          onTap: () => _showContactConfirm(
            "Call Number",
            "Do you want to call ${PortfolioData.phone}?",
            "tel:${PortfolioData.phone.replaceAll(' ', '')}",
          ),
        ),
        const SizedBox(height: 24),
        _buildInfoRow(
          Icons.location_on_outlined,
          "LOCATION",
          PortfolioData.location,
          onTap: () => _showContactConfirm(
            "Open Location",
            "Do you want to view Surat, Gujarat, India on Google Maps?",
            "https://www.google.com/maps/search/?api=1&query=Surat,+Gujarat,+India",
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
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

  Widget _buildFormCard() {
    return CustomCard(
      glowColor: const Color(0xFF25D366),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Send Message",
                style: ThemeConfig.h3.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _nameController,
                label: "YOUR NAME",
                validator: (val) => val == null || val.isEmpty ? "Please enter your name" : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _emailController,
                label: "EMAIL ADDRESS",
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val == null || !val.contains("@") ? "Please enter a valid email" : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _subjectController,
                label: "SUBJECT",
                validator: (val) => val == null || val.isEmpty ? "Please enter a subject" : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _messageController,
                label: "MESSAGE",
                maxLines: 4,
                validator: (val) => val == null || val.isEmpty ? "Please write your message" : null,
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _submitViaWhatsApp,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF25D366),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF25D366).withOpacity(0.2),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            )
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.whatsapp,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Send via WhatsApp",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _submitViaEmail,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        decoration: BoxDecoration(
                          color: ThemeConfig.primary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: ThemeConfig.primary.withOpacity(0.2),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            )
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mail_outline_rounded,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Send via Email",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
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
              if (kIsWeb) {
                html.window.open(actionUrl, '_blank');
              } else {
                launchUrl(Uri.parse(actionUrl), mode: LaunchMode.externalApplication);
              }
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
