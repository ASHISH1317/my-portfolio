import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import '../data/portfolio_data.dart';

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
      _clearForm();
    }
  }

  void submitViaEmail(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final subjectText = "Portfolio Query: ${subjectController.text}";
      final body = "Name: ${nameController.text}\nEmail: ${emailController.text}\n\nMessage:\n${messageController.text}";
      final url = "mailto:$email?subject=${Uri.encodeComponent(subjectText)}&body=${Uri.encodeComponent(body)}";
      
      launchURL(url);
      _clearForm();
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

  void _clearForm() {
    nameController.clear();
    emailController.clear();
    subjectController.clear();
    messageController.clear();
  }
}
