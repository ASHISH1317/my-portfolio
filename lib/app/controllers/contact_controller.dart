import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import '../data/portfolio_data.dart';
import '../widgets/cool_dialog.dart';

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

  final RxBool isLoading = false.obs;
  final RxnString selectedTechnology = RxnString();
  final RxnString selectedBudget = RxnString();
  final RxnString selectedTimeline = RxnString();
  final RxBool scheduleCall = false.obs;
  final Rxn<DateTime> selectedDateTime = Rxn<DateTime>();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }

  Future<void> sendDirectMessage(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (scheduleCall.value && selectedDateTime.value == null) {
        _showStatusDialog(
          context: context,
          title: "Selection Required",
          message: "Please select a date and time for the meeting call.",
          icon: Icons.calendar_today_rounded,
          color: Colors.orangeAccent,
        );
        return;
      }
      isLoading.value = true;
      try {
        final body = {
          "name": nameController.text,
          "email": emailController.text,
          "subject": subjectController.text,
          "message": messageController.text,
          "technology": selectedTechnology.value ?? "N/A",
          "budget": selectedBudget.value ?? "N/A",
          "timeline": selectedTimeline.value ?? "N/A",
          "meetingTime": (scheduleCall.value && selectedDateTime.value != null)
              ? selectedDateTime.value!.toIso8601String()
              : "",
        };

        final response = await http.post(
          Uri.parse("https://script.google.com/macros/s/AKfycbwAPtuDrvpZmuIg_YzvGFS2iSAr5brLED9B30eQQSQvg44XYGv8qB_M1jETqAM26MBxZg/exec"),
          headers: {"Content-Type": "text/plain"},
          body: jsonEncode(body),
        );

        if (!context.mounted) return;

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data["status"] == "success") {
            _clearForm();

            final String? meetLink = data["meetLink"];
            final String? meetingTime = data["meetingTime"];

            String successMsg = "Thank you for reaching out! Your message has been sent successfully. I will get back to you soon.";
            if (meetLink != null && meetLink != "N/A" && meetingTime != null && meetingTime != "N/A") {
              successMsg += "\n\n📅 Meeting Scheduled:\nTime: $meetingTime\n\nGoogle Meet Link: $meetLink\n\n(A calendar invite has also been sent to your email!)";
            }

            _showStatusDialog(
              context: context,
              title: "Message Sent!",
              message: successMsg,
              icon: Icons.check_circle_outline_rounded,
              color: Colors.greenAccent,
            );
          } else {
            _showStatusDialog(
              context: context,
              title: "Submission Error",
              message: data["message"] ?? "Something went wrong. Please try again.",
              icon: Icons.error_outline_rounded,
              color: Colors.redAccent,
            );
          }
        } else {
          _showStatusDialog(
            context: context,
            title: "Network Error",
            message: "Failed to connect to server (Status Code: ${response.statusCode}). Please check your internet connection.",
            icon: Icons.signal_wifi_connected_no_internet_4_rounded,
            color: Colors.orangeAccent,
          );
        }
      } catch (e) {
        _showStatusDialog(
          context: context,
          title: "An Error Occurred",
          message: "An unexpected error occurred while sending your message: $e\n\nPlease try again later.",
          icon: Icons.warning_amber_rounded,
          color: Colors.redAccent,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  void _showStatusDialog({
    required BuildContext context,
    required String title,
    required String message,
    required IconData icon,
    required Color color,
  }) {
    showCoolDialog(
      context: context,
      title: title,
      message: message,
      icon: icon,
      accentColor: color,
      primaryButtonText: "OK",
      onPrimaryPressed: () => Navigator.of(context).pop(),
    );
  }

  void submitViaWhatsApp(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final techPrefix = selectedTechnology.value != null ? "Framework: ${selectedTechnology.value}\n" : "";
      final budgetPrefix = selectedBudget.value != null ? "Budget: ${selectedBudget.value}\n" : "";
      final timelinePrefix = selectedTimeline.value != null ? "Timeline: ${selectedTimeline.value}\n" : "";
      final meetPrefix = (scheduleCall.value && selectedDateTime.value != null) ? "Meeting Request: ${selectedDateTime.value.toString()}\n" : "";

      final text = "Hello Ashish,\n\nName: ${nameController.text}\nEmail: ${emailController.text}\n$techPrefix$budgetPrefix$timelinePrefix${meetPrefix}Subject: ${subjectController.text}\n\nMessage: ${messageController.text}";
      final url = "https://wa.me/919913629852?text=${Uri.encodeComponent(text)}";

      launchURL(url);
      _clearForm();
    }
  }

  void submitViaEmail(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final techPrefix = selectedTechnology.value != null ? "[${selectedTechnology.value}] " : "";
      final budgetPrefix = selectedBudget.value != null ? "[Budget: ${selectedBudget.value}] " : "";
      final timelinePrefix = selectedTimeline.value != null ? "[Timeline: ${selectedTimeline.value}] " : "";
      final meetPrefix = (scheduleCall.value && selectedDateTime.value != null) ? "[Meeting: ${selectedDateTime.value.toString()}] " : "";

      final subjectText = "Portfolio Query: $techPrefix$budgetPrefix$timelinePrefix$meetPrefix${subjectController.text}";
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
    selectedTechnology.value = null;
    selectedBudget.value = null;
    selectedTimeline.value = null;
    scheduleCall.value = false;
    selectedDateTime.value = null;
  }
}
