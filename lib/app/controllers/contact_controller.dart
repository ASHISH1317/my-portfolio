import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import '../data/portfolio_data.dart';
import '../data/theme_config.dart';

class ContactController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  final String email = PortfolioData.email;
  final String emailUrl = PortfolioData.emailUrl;
  final String phone = PortfolioData.phone;
  final String location = PortfolioData.location;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }

  void submitViaWhatsApp(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final text = "Hello Ashish,\n\nName: ${nameController.text}\nEmail: ${emailController.text}\nSubject: ${subjectController.text}\n\nMessage: ${messageController.text}";
      final url = "https://wa.me/919913629852?text=${Uri.encodeComponent(text)}";
      
      launchURL(url);
      
      showSuccessDialog(context, "WhatsApp Redirect", "Redirecting you to chat on WhatsApp...", const Color(0xFF25D366));
    }
  }

  void submitViaEmail(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final subjectText = "Portfolio Query: ${subjectController.text}";
      final body = "Name: ${nameController.text}\nEmail: ${emailController.text}\n\nMessage:\n${messageController.text}";
      final url = "mailto:$email?subject=${Uri.encodeComponent(subjectText)}&body=${Uri.encodeComponent(body)}";
      
      launchURL(url);
      
      showSuccessDialog(context, "Email Redirect", "Opening your default email app...", ThemeConfig.primary);
    }
  }

  Future<void> launchURL(String urlString) async {
    if (kIsWeb) {
      html.window.open(urlString, '_blank');
    } else {
      final Uri url = Uri.parse(urlString);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        debugPrint("Could not launch $urlString");
      }
    }
  }

  void showSuccessDialog(BuildContext context, String title, String message, Color accentColor) {
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
              nameController.clear();
              emailController.clear();
              subjectController.clear();
              messageController.clear();
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
}
